import 'dart:ffi';

import 'package:either_type/either_type.dart';
import 'package:http/http.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/domain/entities/customer_table_entity.dart';
import 'package:zana_storage/features/domain/entities/dashboard_entity.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_table_entity.dart';
import 'package:zana_storage/features/domain/entities/login_entity.dart';
import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/domain/entities/product_log_entity.dart';
import 'package:zana_storage/features/domain/entities/product_table_entity.dart';
import 'package:zana_storage/features/domain/entities/qr_product_entity.dart';
import 'package:zana_storage/features/domain/entities/response_entity.dart';
import 'package:zana_storage/features/domain/entities/user_info_entity.dart';

abstract class ZanaStorageRepository{
  ///////////////  Login Services ////////////
  Future<Either<Failure,LoginEntity>> login(String body);
  Future<Either<Failure,bool>> logOut();

  ///////////////  Customers Services /////////
  Future<Either<Failure,CustomerTableEntity>> getCustomers(String parameters);
  Future<Either<Failure,CustomerEntity>> updateCustomer(String body,String id);
  Future<Either<Failure,CustomerEntity>> addCustomer(String body);

  ///////////////  Invoice Services ///////////
  Future<Either<Failure,InvoiceTableEntity>> getInvoices(String parameters);
  Future<Either<Failure,InvoiceEntity>> getInvoice(String id);
  Future<Either<Failure,ResponseEntity>> createInvoice(String body);
  Future<Either<Failure,InvoiceEntity>> updateInvoice(String body,String id);

  ///////////////  User Services ////////////////
  Future<Either<Failure,UserInfoEntity>> getUserInfo(bool splash);

  ///////////////  Setting Service //////////////
  Future<Either<Failure,bool>> saveLocale(bool isUs);
  Future<Either<Failure,bool>> getLocale();

  ///////////////  Product Service //////////////
  Future<Either<Failure,ProductTableEntity>> getProducts(String parameters);
  Future<Either<Failure,ProductLogEntity>> getProductLogs(String parameters);
  Future<Either<Failure,ManageProductEntity>> manageProduct(String body,String id);
  Future<Either<Failure,QrProductEntity>> getProductByQr(String barCode);
  Future<Either<Failure,ProductEntity3>> getProduct(String id);
  Future<Either<Failure,AddProductResponseEntity>> addProduct(String body);
  Future<Either<Failure,bool>> updateProduct(String body,String id);

  //////////////  Init Service //////////////////
  Future<Either<Failure,InitEntity>> getInit();
  Future<Either<Failure,bool>> clearInit();

  /////////////  Dashboard Service ////////////
  Future<Either<Failure,DashboardEntity>> getDashboard();


}