import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/core/error/exceptions.dart';
import 'package:zana_storage/core/generics.dart';
import 'package:zana_storage/features/data/model/error_model.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';

abstract class ZanaStorageRemoteDataSource {
  Future<T> get<T, K>(String url);
  Future<T> post<T, K>(String body, String url);
}

class ZanaStorageRemoteDatasourceImpl implements ZanaStorageRemoteDataSource{
  String token;
  GetStorage box;
  ZanaStorageRemoteDatasourceImpl(){
    box = GetStorage();
    token = box.read("token");
  }

  @override
  Future<T> get<T, K>(String url) async{
    // TODO: implement get
    token = box.read("token");
    if(token == null)
      token = "";
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try{
      final response = await http.get(
        baseUrl + url,
        headers: headers,
      ).timeout(Duration(seconds: timeOut));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final result = Generics.fromJson<T, K>(json.decode(response.body));
        return result;
      } else
        if(response.statusCode == 401 || response.statusCode == 404)
          Get.offAllNamed(ZanaStorageRoutes.loginPage);
        else
        throw ServerException(errorCode: response.statusCode);
    }on SocketException catch(e){
    throw ServerException(errorCode: 0);
    }
    on TimeoutException catch(e){
    throw ServerException(errorCode: 1);
    }

  }

  @override
  Future<T> post<T, K>(String body, String url) async{
    // TODO: implement post
    token = box.read("token");
    if(token == null)
      token = "";
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    try{
      final response = await http.post(baseUrl + url, body: body, headers: headers).timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        print(response.body);
        print(T);
        if(T == bool)
          return true as T;
        final result = Generics.fromJson<T, K>(json.decode(response.body));
        return result;
      }
      if(response.statusCode == 422)
        {
          if(url.contains('login'))
            throw ServerException(errorCode: response.statusCode,errorMessage: ['Email or password is incorrect']);
          final result = ErrorModel.fromJson(json.decode(response.body));
          throw ServerException(errorCode: result.status,errorMessage: result.message.products);
        }
      else
        if(response.statusCode == 401 && !url.contains("login") || response.statusCode == 404)
          Get.toNamed(ZanaStorageRoutes.loginPage);
        else
          throw ServerException(errorCode: response.statusCode,);
    }on SocketException catch(e){
      throw ServerException(errorCode: 0);
    }
    on TimeoutException catch(e){
      throw ServerException(errorCode: 1);
    }

  }

}