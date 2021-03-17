import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_id_usecase.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';

import 'init_controller.dart';

class ProductDetailController extends GetxController{
  var getProductState = StateStatus.INITIAL.obs;
  Rx<ProductEntity3> responseEntity = new ProductEntity3().obs;
  var pResponse;
  getProduct(String id){
    getProductState.value = StateStatus.LOADING;
    GetProductByIdUseCase getProductByIdUseCase = Get.find();
    getProductByIdUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        responseEntity.value = response.right;
        getProductState.value = StateStatus.SUCCESS;
      }else if(response.isLeft){
        getProductState.value = StateStatus.ERROR;
      }
    });
  }
}