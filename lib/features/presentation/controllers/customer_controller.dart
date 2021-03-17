import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/domain/entities/customer_table_entity.dart';
import 'package:zana_storage/features/domain/usecases/customer/add_customer_usecase.dart';
import 'package:zana_storage/features/domain/usecases/customer/get_customers_usecase.dart';
import 'package:zana_storage/features/domain/usecases/customer/update_customer_usecase.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/bindings/customer_binding.dart';
import 'package:zana_storage/features/presentation/pages/customers_page.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/utils/state_status.dart';

class CustomerController extends GetxController{

  RxList customers = [].obs;
  Rx<CustomerEntity> customer = new CustomerEntity().obs;
  Rx<CustomerEntity> addedCustomer = new CustomerEntity().obs;
  Rx<CustomerTableEntity> customerTableEntity = new CustomerTableEntity().obs;
  var getCustomerState = StateStatus.INITIAL.obs;
  RxBool updateCustomerState = false.obs;
  RxBool addCustomerState = false.obs;
  getCustomers(String parameters){
    getCustomerState.value = StateStatus.LOADING;
    GetCustomersUseCase getAllCustomersUseCase = Get.find();
    getAllCustomersUseCase.call(Params(body: parameters)).then((response) {
      if(response.isRight){
        getCustomerState.value = StateStatus.SUCCESS;
        // Get.offAll(HomePage());
        customerTableEntity.value = response.right;
        customers.addAll(response.right.customers);
      }
      else if(response.isLeft){
        getCustomerState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  updateCustomer(String body,String id,ValueChanged<bool> parentAction){
    updateCustomerState.value = true;
    UpdateCustomerUseCase updateCustomerUseCase = Get.find();
    updateCustomerUseCase.call(Params(body: body,id: id)).then((response){
      updateCustomerState.value = false;
      if(response.isRight){
        customer.value = response.right;
       MyAlertDialog.show(["Successfully edited".tr], true);
        parentAction(false);
      }
      else if(response.isLeft){
        errorAction(response.left);
        parentAction(true);
      }
    });
  }
  addCustomer(String body,ValueChanged<bool> parentAction){
    addCustomerState.value = true;
    AddCustomerUseCase addCustomerUseCase = Get.find();
    addCustomerUseCase.call(Params(body: body)).then((response) {
      addCustomerState.value = false;
      if(response.isRight) {
        // MyAlertDialog.show(["Successfully Added".tr], true);
        addedCustomer.value = response.right;
        if(parentAction != null) {
          Get.to(
              CustomerPage(
                isCustomerPage: true,
                parentAction: action,
              ),
              binding: CustomerBinding());
          parentAction(true);
        }
        else Get.back();
        // Get.offAndToNamed(ZanaStorageRoutes.customerPage);
      } else
        if(response.isLeft) {
        errorAction(response.left);
      }
    });


  }
  action(CustomerEntity entity){

  }
  errorAction(ServerFailure failure){
    String errorMessage="Server error".tr;
    if(failure.errorCode == 0 || failure.errorCode == 1)
      errorMessage = 'noInternetTxt'.tr;
    MyAlertDialog.show([errorMessage], true);
  }
}