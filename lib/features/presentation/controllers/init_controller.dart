import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/usecases/init/init_usecase.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';

class InitController extends GetxController{
  Rx<InitEntity> initEntity = new InitEntity().obs;
  var initStatus = StateStatus.INITIAL.obs;

  getInit(ValueChanged<InitEntity> parentAction){
    initStatus.value = StateStatus.LOADING;
    InitUseCase initUseCase = Get.find();
    initUseCase.call(NoParams()).then((response) {
      if(response.isRight) {
        initStatus.value = StateStatus.SUCCESS;
        parentAction(response.right);
        initEntity.value = response.right;
      }
      else
      if(response.isLeft) {
        initStatus.value = StateStatus.ERROR;
        parentAction(null);
      }
    });
  }
}