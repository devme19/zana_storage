import 'dart:convert';
import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multipart_request/multipart_request.dart' as multiPartResponse;
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/add_product_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/update_product_usecase.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';

class AddProductController extends GetxController{
  var uploadImageState = StateStatus.INITIAL.obs;
  var addProductState = StateStatus.INITIAL.obs;
  var updateProductState = StateStatus.INITIAL.obs;
  RxInt uploadProgress = 0.obs;
  RxBool imagePicked = false.obs;
  File imageFile;
  UploadImageResponse uploadImageResponse;
  // RxBool uploadProgressVisibility = false.obs;
  // RxBool deleteIconVisibility = false.obs;

  upLoadImage(File imgFile,String id)async{
    uploadProgress.value = 0;
    imageFile = imgFile;
    imagePicked.value = true;
    uploadImageState.value = StateStatus.LOADING;
    // uploadProgressVisibility.value = true;
    if(imageFile != null){
      var request = multiPartResponse.MultipartRequest();

      request.setUrl(baseUrl+"product/upload");
      GetStorage box = GetStorage();
      String token = box.read("token");
      if(token == null)
        token = "";
      var headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
      request.addHeaders(headers);
      request.addFile("file", imgFile.path);
      if(id != "") request.addField('productId', id);
      multiPartResponse.Response response = request.send();
      response.onError = () {
        print("Error");
        uploadImageState.value = StateStatus.ERROR;
        // uploadProgressVisibility.value = false;
      };

      response.onComplete = (response) {
        print(response);
        // print(json.decode(response));
        // json = response;
        // print(json);
        // uploadImageState.value = StateStatus.SUCCESS;
        // uploadImageResponse = ;
        uploadImageResponse=UploadImageResponse.fromJson(json.decode(response));
        uploadImageState.value = StateStatus.SUCCESS;
        // deleteIconVisibility.value = true;
        // uploadProgressVisibility.value = false;

      };

      response.progress.listen((int progress) {
        uploadProgress.value = progress;
        print(progress);
      });
    }
  }
  addProduct(String body,ValueChanged<bool> parentAction){
    addProductState.value = StateStatus.LOADING;
    AddProductUseCase addProductUseCase = Get.find();
    addProductUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        addProductState.value = StateStatus.SUCCESS;
        Get.toNamed(ZanaStorageRoutes.detailProductPage,arguments: response.right.product.id);
        clearImage();
        parentAction(true);
      }else if(response.isLeft){
        addProductState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  updateProduct(String body,String id){
    updateProductState.value = StateStatus.LOADING;
    UpdateProductUseCase updateProductUseCase = Get.find();
    updateProductUseCase.call(Params(body: body,id: id)).then((response) {
      if(response.isRight){
        updateProductState.value = StateStatus.SUCCESS;
        Get.back();
        // clearImage();
      }else if(response.isLeft){
        updateProductState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  clearImage(){
    uploadImageResponse = null;
    imagePicked.value = false;
  }
  errorAction(ServerFailure failure){
    String errorMessage="Server error".tr;
    if(failure.errorCode == 0 || failure.errorCode == 1)
      errorMessage = 'noInternetTxt'.tr;
    MyAlertDialog.show([errorMessage], true);
  }

}
class UploadImageResponse {
    String data;
    String message;
    int status;

    UploadImageResponse({this.data, this.message, this.status});

    factory UploadImageResponse.fromJson(Map<String, dynamic> json) {
        return UploadImageResponse(
            data: json['data'],
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['data'] = this.data;
        data['message'] = this.message;
        data['status'] = this.status;
        return data;
    }
}
