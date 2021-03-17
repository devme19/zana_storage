import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/user_info_entity.dart';
import 'package:zana_storage/features/domain/usecases/user/get_user_info_usecase.dart';

class UserController extends GetxController{

  Rx<UserInfoEntity> userInfo = new UserInfoEntity().obs;
  RxBool error = false.obs;
  getUserInfo(){
    error.value = false;
    GetUserInfoUseCase getUserInfoUseCase = Get.find();
    getUserInfoUseCase.call(Params(boolValue: false)).then((response) {
      if(response.isRight) {
        userInfo.value = response.right;
      }
      else if(response.isLeft)
        {
          ServerFailure failure = response.left;
          // if(failure.errorCode == 0 || failure.errorCode == 1)
          //   Get.snackbar(
          //       'error'.tr, 'noInternetTxt'.tr, duration: Duration(seconds: 3),
          //       colorText: Colors.black);
          error.value = true;
        }
    });
  }
}