import 'dart:ffi';

import 'package:either_type/src/either.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:http/src/response.dart';
import 'package:zana_storage/core/error/exceptions.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/features/data/datasources/local/zana_storage_local_datasource.dart';
import 'package:zana_storage/features/data/datasources/remote/zana_storage_remote_datasource.dart';
import 'package:zana_storage/features/data/model/add_product_response_model.dart';
import 'package:zana_storage/features/data/model/customer_model.dart';
import 'package:zana_storage/features/data/model/customer_table_model.dart';
import 'package:zana_storage/features/data/model/dashboard_model.dart';
import 'package:zana_storage/features/data/model/init_model.dart';
import 'package:zana_storage/features/data/model/invoice_model.dart';
import 'package:zana_storage/features/data/model/invoice_table_model.dart';
import 'package:zana_storage/features/data/model/login_model.dart';
import 'package:zana_storage/features/data/model/manage_product_model.dart';
import 'package:zana_storage/features/data/model/product_log_model.dart';
import 'package:zana_storage/features/data/model/product_model3.dart';
import 'package:zana_storage/features/data/model/product_table_model.dart';
import 'package:zana_storage/features/data/model/qr_product_model.dart';
import 'package:zana_storage/features/data/model/response_model.dart';
import 'package:zana_storage/features/data/model/user_info_model.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/entities/customer_table_entity.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/domain/entities/dashboard_entity.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_table_entity.dart';
import 'package:zana_storage/features/domain/entities/login_entity.dart';
import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/domain/entities/product_log_entity.dart';
import 'package:zana_storage/features/domain/entities/product_table_entity.dart';
import 'package:zana_storage/features/domain/entities/qr_product_entity.dart';
import 'package:zana_storage/features/domain/entities/response_entity.dart';
import 'package:zana_storage/features/domain/entities/user_info_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';
import 'package:http/http.dart' as http;

class ZanaStorageRepositoryImpl implements ZanaStorageRepository{

  final ZanaStorageRemoteDataSource remoteDataSource;
  final ZanaStorageLocalDataSource localDataSource;

  ZanaStorageRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource
  });
 //////////////////// Identity //////////////////////////
  @override
  Future<Either<Failure, LoginEntity>> login(String body) async{
    // TODO: implement login
    try {
      final response = await remoteDataSource.post<LoginModel, Null>(body,"auth/login");
      localDataSource.saveToken(response.accessToken);
      print('MyToken:'+localDataSource.getToken());
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
 ///////////////////// Customer ///////////////////////////////
  @override
  Future<Either<Failure, CustomerTableEntity>> getCustomers(String parameters) async{
    try{
      final response = await remoteDataSource.get<CustomerTableModel,Null>("customer/list?$parameters");
      return Right(response);
    } on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> updateCustomer(String body, String id) async{
    // TODO: implement updateCustomer
    try{
      final response = await remoteDataSource.post<CustomerModel,Null>(body, "customer/update?id=$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, CustomerEntity>> addCustomer(String body) async{
    // TODO: implement addCustomer
    try{
      final response = await remoteDataSource.post<CustomerModel,Null>(body, "customer/create");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  //////////////////// Invoice ////////////////////////////////
  @override
  Future<Either<Failure, InvoiceTableEntity>> getInvoices(String parameters) async{
    // TODO: implement getAllCustomers
    try{
      final response = await remoteDataSource.get<InvoiceTableModel,Null>("invoice/list?$parameters");
      return Right(response);
    } on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  Future<Either<Failure, InvoiceEntity>> getInvoice(String id) async{
    // TODO: implement getAllCustomers
    try{
      final response = await remoteDataSource.get<InvoiceModel,Null>("invoice/show/?id="+id);
      return Right(response);
    } on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }

  @override
  Future<Either<Failure, ResponseEntity>> createInvoice(String body) async{
    // TODO: implement createInvoice
    try{
      print(body);
      final response = await remoteDataSource.post<ResponseModel,Null>(body, "invoice/create");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> updateInvoice(String body,String id) async{
    // TODO: implement updateInvoice
    try{
      final response = await remoteDataSource.post<InvoiceModel,Null>(body, "invoice/change?id=$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }


  //////////////////// User /////////////////////////////////////
  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo(bool splash) async{
    // TODO: implement getAllCustomers
    try {
      if(!splash) {
        UserInfoModel userInfo = localDataSource.getUserInfo();
        if (userInfo != null)
          return Right(userInfo);
      }
        final response = await remoteDataSource.get<UserInfoModel, Null>(
            "store/show");
        localDataSource.saveUserInfo(response);
        return Right(response);
    }
      on ServerException catch (e) {
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  //////////////////// Setting /////////////////////////////////
  @override
  Future<Either<Failure, bool>> getLocale() async{
    // TODO: implement getLocale
    try{
      return Right(localDataSource.getLocale());
    }on CacheException catch(e){
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocale(bool isUs) async{
    // TODO: implement saveLocale
    try {
      return Right(localDataSource.saveLocale(isUs));
    }
    on CacheException catch (e) {
      return Left(CacheFailure());
    }
  }
  ///////////////////// Product ///////////////////////
  @override
  Future<Either<Failure, ProductTableEntity>> getProducts(String parameters) async{
    // TODO: implement getProducts
    try{
      final response = await remoteDataSource.get<ProductTableModel,Null>("product/list?$parameters");
      return Right(response);
    } on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, ProductLogEntity>> getProductLogs(String parameters) async{
    // TODO: implement getProducts
    try{
      final response = await remoteDataSource.get<ProductLogModel,Null>("product/logs?$parameters");
      return Right(response);
    } on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }

  @override
  Future<Either<Failure, ManageProductEntity>> manageProduct(String body,String id) async{
    // TODO: implement manageProduct
    try{
      final response = await remoteDataSource.post<ManageProductModel,Null>(body, 'product/manage?id='+id);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }

  @override
  Future<Either<Failure, QrProductEntity>> getProductByQr(String barCode) async{
    // TODO: implement getProductByQr
   try{
     final response = await remoteDataSource.get<QrProductModel,Null>("product/showqr?barcode=$barCode");
     return Right(response);
   }on ServerException catch(e){
     return Left(ServerFailure(errorCode: e.errorCode));
   }
  }

  @override
  Future<Either<Failure, ProductEntity3>> getProduct(String id) async{
    // TODO: implement getProduct
    try{
      final response = await remoteDataSource.get<ProductModel3,Null>("product/show?id=$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, AddProductResponseEntity>> addProduct(String body) async{
    try{
      final response = await remoteDataSource.post<AddProductResponseModel,Null>(body, 'product/create');
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, bool>> updateProduct(String body,String id) async{
    try{
      final response = await remoteDataSource.post<bool, Null>(body,'product/update?id=$id');
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
//////////////////////////// Init ///////////////////////////////////
  @override
  Future<Either<Failure, InitEntity>> getInit() async{
    // TODO: implement getInit
    try{
      InitModel initModel = localDataSource.getInit();
      if(initModel != null)
        return Right(initModel);
      final response = await remoteDataSource.get<InitModel,Null>("init/index");
      localDataSource.saveInit(response);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, bool>> clearInit() async{
    // TODO: implement clearInit
    try{
      localDataSource.clearInit();
      return Right(true);
    } on CacheException catch(e){
      return Left(CacheFailure());
    }
  }
  /////////////////// Dashboard ///////////////////
  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() async{
    // TODO: implement getDashboard
    try{
      final response = await remoteDataSource.get<DashboardModel,Null>("statistics/dashbaord");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async{
    try{
      localDataSource.logOut();
      return Right(true);
    } on CacheException catch(e){
      return Left(CacheFailure());
    }
  }
}