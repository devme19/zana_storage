import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:zana_storage/features/domain/entities/product_log_entity.dart';
import 'package:zana_storage/features/domain/entities/product_table_entity.dart';
import 'package:zana_storage/features/domain/entities/qr_product_entity.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_qr_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_logs_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_products_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/manage_product_usecase.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/utils/state_status.dart';

class ProductController extends GetxController{
  Rx<ProductTableEntity> productTable = new ProductTableEntity().obs;
  Rx<ProductLogEntity> productLog = new ProductLogEntity().obs;
  Rx<ProductEntity2> product = new ProductEntity2().obs;
  Rx<ManageProductEntity> manageProductLog = new ManageProductEntity().obs;
  RxList products = [].obs;
  RxList productLogs = [].obs;
  RxBool flag = false.obs;
  RxString inStock = "".obs;
  RxString productTitle = "".obs;
  var getProductsState = StateStatus.INITIAL.obs;
  var getProductLogsState = StateStatus.INITIAL.obs;
  var manageProductState = StateStatus.INITIAL.obs;
  var getProductByQrState = StateStatus.INITIAL.obs;
  RxBool checkVisible = false.obs;
  Timer _timer;
  int _start = 4;

  void startTimer() {
    _start = 4;
    checkVisible.value = true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          checkVisible.value = false;
          _timer.cancel();
        } else {
          _start--;
        }
      },
    );
  }
  getProducts(String parameters){
    product = new ProductEntity2().obs;
    getProductsState.value = StateStatus.LOADING;
    GetProductsUseCase getProductsUseCase = Get.find();
    getProductsUseCase.call(Params(body: parameters)).then((response){
      if(response.isRight) {
        getProductsState.value = StateStatus.SUCCESS;
        productTable.value = response.right;
        products.addAll(productTable.value.products);
      } else
      if(response.isLeft){
        getProductsState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  getProductLogs(String parameters){
    getProductLogsState.value = StateStatus.LOADING;
    GetProductLogsUseCase getProductLogsUseCase = Get.find();
    getProductLogsUseCase.call(Params(body: parameters)).then((response){
      if(response.isRight) {
        getProductLogsState.value = StateStatus.SUCCESS;
        productLog.value = response.right;
        productLogs.addAll(productLog.value.logs);
        inStock.value = productLog.value.product.quantity.toString();
        productTitle.value = productLog.value.product.title;
        update();
      }
      else
      if(response.isLeft){
        getProductLogsState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  manageProduct(String body,String id,ValueChanged<bool> parentAction) {
    manageProductState.value = StateStatus.LOADING;
    ManageProductUseCase manageProductUseCase = Get.find();
    manageProductUseCase.call(Params(body: body,id: id)).then((response) {

      if(response.isRight) {
        manageProductState.value = StateStatus.SUCCESS;
        manageProductLog.value = response.right;
        // productLogs = productLogs.sublist(1)..addAll(productLogs.sublist(0,1));
        inStock.value = manageProductLog.value.product.quantity.toString();
        flag.value = true;
        Get.snackbar('Success', 'done successfully');
        parentAction(true);
        startTimer();
      }
      else
      if(response.isLeft){
        manageProductState.value = StateStatus.ERROR;
        errorAction(response.left);
        Get.snackbar('Error', 'an error occurred');
        parentAction(false);
      }

    });
  }
  getProductByQr(String qr,ValueChanged<ProductEntity2> parentAction){
    getProductByQrState.value = StateStatus.LOADING;
    GetProductByQrUseCase getProductByQrUseCase = Get.find();
    getProductByQrUseCase.call(Params(body: qr)).then((response) {
      if(response.isRight) {
        getProductByQrState.value = StateStatus.SUCCESS;
        product.value = new ProductEntity2(
            id: response.right.id,
            title: response.right.title,
            quantity: response.right.quantity,
            symbol: response.right.currency.symbol,
            sku: response.right.sku,
            price: response.right.price,
            image: response.right.image,
        );
        if(parentAction!= null) {
          parentAction(product.value);
        }
        // Get.back();
      }
      else
      if(response.isLeft){
        getProductByQrState.value = StateStatus.ERROR;
        errorAction(response.left);
      }

    });
  }
  reset(){
    productTable = new ProductTableEntity().obs;
    productLog = new ProductLogEntity().obs;
    product = new ProductEntity2().obs;
    manageProductLog = new ManageProductEntity().obs;
    products.clear();
    productLogs.clear();
    flag = false.obs;
    inStock = "".obs;
    productTitle = "".obs;
  }
  errorAction(ServerFailure failure){
    if(failure.errorCode == 0 || failure.errorCode == 1) {
      MyAlertDialog.show(['noInternetTxt'.tr],true);
    }
    else
    MyAlertDialog.show(['Connection failed'.tr],true);
  }
}