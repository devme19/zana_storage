import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/dashboard_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:zana_storage/features/domain/usecases/dashboard/get_dashboard_usecase.dart';
import 'package:zana_storage/features/domain/usecases/logout/log_out_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_qr_usecase.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/utils/state_status.dart';

class DashboardController extends GetxController{
  var getDashboardState = StateStatus.INITIAL.obs;
  Rx<ProductEntity2> product = new ProductEntity2().obs;
  Rx<DashboardEntity> dashboardEntity = new DashboardEntity().obs;
  RxBool getProductByQrState = false.obs;
  getDashboard(){
    getDashboardState.value = StateStatus.LOADING;
    GetDashboardUseCase getDashboardUseCase = Get.find();
    getDashboardUseCase.call(NoParams()).then((response){
      if(response.isRight){
        getDashboardState.value = StateStatus.SUCCESS;
        dashboardEntity.value = response.right;
      }else if(response.isLeft){
        getDashboardState.value = StateStatus.ERROR;
      }

    });
  }
  getProductByQr(String qr,ValueChanged<ProductEntity2> parentAction){
    getProductByQrState.value =true;
    GetProductByQrUseCase getProductByQrUseCase = Get.find();
    getProductByQrUseCase.call(Params(body: qr)).then((response) {
      getProductByQrState.value = false;
      if(response.isRight) {
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
        errorAction(response.left);
      }

    });
  }
  logOut(){
    LogOutUseCase logOutUseCase = Get.find();
    logOutUseCase.call(NoParams()).then((response){
      if(response.isRight){
        Get.reset();
      }else if(response.isLeft){
      }

    });
  }
  errorAction(ServerFailure failure){
    if(failure.errorCode == 0 || failure.errorCode == 1) {
      MyAlertDialog.show(['noInternetTxt'.tr],true);
    }
    else
      MyAlertDialog.show(['Connection failed'.tr],true);
  }
}