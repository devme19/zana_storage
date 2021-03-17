import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/core/error/exceptions.dart';
import 'package:zana_storage/features/data/model/init_model.dart';
import 'package:zana_storage/features/data/model/user_info_model.dart';

abstract class ZanaStorageLocalDataSource{
    saveToken(String token);
    String getToken();
    saveUserInfo(UserInfoModel userInfo);
    UserInfoModel getUserInfo();
    bool saveLocale(bool isUs);
    bool getLocale();
    saveInit(InitModel initModel);
    InitModel getInit();
    clearInit();
    bool logOut();
}

class ZanaStorageLocalDataSourceImpl implements ZanaStorageLocalDataSource{
  GetStorage box;

  ZanaStorageLocalDataSourceImpl(){
    box = GetStorage();
  }


  @override
  saveToken(String token) {
    // TODO: implement saveToken
    try{
      box.write('token', token);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  String getToken() {
    // TODO: implement getToken
    try{
      return box.read('token');
    }catch(e){
      throw CacheException();
    }

  }

  @override
  UserInfoModel getUserInfo() {
    // TODO: implement getUserInfo

    try{
      String s = box.read('userInfo');
      if (s == null) return null;
      else
        return UserInfoModel.fromJson(json.decode(s));
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveUserInfo(UserInfoModel userInfo) {
    // TODO: implement saveUserInfo

    try{
      String s = json.encode(userInfo.toJson());
      box.write("userInfo", s);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveLocale(bool isUs) {
    // TODO: implement saveLocale
    try{
      box.write("isUS", isUs);
      return true;
    }on Exception catch(e)
    {
      return false;
    }
  }

  @override
  bool getLocale() {
    // TODO: implement getLocale
    try{
      return box.read("isUS");
    }catch(e){
      throw CacheException();
    }

  }

  @override
  InitModel getInit() {
    // TODO: implement getInit
    try{
      String jsonStr = box.read('init');
      if (jsonStr == null) return null;
      else
        return InitModel.fromJson(json.decode(jsonStr));
    }catch(e){
      throw CacheException();
    }

  }

  @override
  saveInit(InitModel initModel) {
    // TODO: implement saveInit
    try{
      box.write("init", json.encode(initModel.toJson()));
    }catch(e){
      throw CacheException();
    }

  }

  @override
  clearInit() {
    // TODO: implement clearInit
    try{
      box.remove("init");
    } catch (e){
      throw CacheException();
    }

  }

  @override
  bool logOut() {
    try{
      box.remove('token');
    } catch (e){
      throw CacheException();
    }
  }

}