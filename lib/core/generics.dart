

import 'package:get/get.dart';
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

class Generics {
  static T fromJson<T,K>(dynamic json) {
    print(T);
    print(K);
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    }
    else
    if (T == LoginModel) {
      return LoginModel.fromJson(json) as T;
    }
    else
    if (T == CustomerModel) {
      return CustomerModel.fromJson(json) as T;
    }
    else
    if (T == CustomerTableModel) {
      return CustomerTableModel.fromJson(json) as T;
    }
    else
    if (T == InvoiceModel) {
      return InvoiceModel.fromJson(json) as T;
    }
    else
    if (T == InvoiceTableModel) {
      return InvoiceTableModel.fromJson(json) as T;
    }
    else
    if (T == AddProductResponseModel) {
      return AddProductResponseModel.fromJson(json) as T;
    }

    else
    if (T == UserInfoModel) {
      return UserInfoModel.fromJson(json) as T;
    }
    else
    if (T == ProductTableModel) {
      return ProductTableModel.fromJson(json) as T;
    }
    else
    if (T == ProductLogModel) {
      return ProductLogModel.fromJson(json) as T;
    }
    else
    if (T == ManageProductModel) {
      return ManageProductModel.fromJson(json) as T;
    }
    else
    if (T == QrProductModel) {
      return QrProductModel.fromJson(json) as T;
    }
    else
    if (T == ProductModel3) {
      return ProductModel3.fromJson(json) as T;
    }
    else
    if (T == InitModel) {
      return InitModel.fromJson(json) as T;
    }
    else
    if (T == DashboardModel) {
      return DashboardModel.fromJson(json) as T;
    }
    else
    if (T == ResponseModel) {
      return ResponseModel.fromJson(json) as T;
    }

      else
        {
        throw Exception("Unknown class");
      }

  }
  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }
    return output;
  }
}