import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/usecases/init/init_usecase.dart';
import 'package:zana_storage/features/domain/usecases/login/login_usecase.dart';
import 'package:zana_storage/features/domain/usecases/user/get_user_info_usecase.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/home_page.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/utils/state_status.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  login(String body){
    loading.value = true;
    LoginUseCase loginUseCase = Get.find();
    GetUserInfoUseCase userInfoUseCase = Get.find();
    InitUseCase initUseCase = Get.find();
    loginUseCase.call(Params(body: body)).then((response){
      loading.value = false;
      if(response.isRight){

        Get.offAllNamed(ZanaStorageRoutes.homePage);
        initUseCase.call(NoParams()).then((value) {});
       userInfoUseCase.call(Params(boolValue: true)).then((value) {
       });
      }
      else if(response.isLeft){
        ServerFailure failure = response.left;
        if(failure.errorCode == 401 || failure.errorCode == 422)
          MyAlertDialog.show(["Email or password is incorrect".tr], true);
          // Get.snackbar('error'.tr, 'userNotExistTxt'.tr,duration: Duration(seconds: 10),colorText: Colors.black);
        else
        if(failure.errorCode == 0 || failure.errorCode == 1)
          MyAlertDialog.show(["noInternetTxt".tr], true);
      }
    });
  }
}