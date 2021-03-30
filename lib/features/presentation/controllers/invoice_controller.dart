import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_table_entity.dart';
import 'package:zana_storage/features/domain/entities/response_entity.dart';
import 'package:zana_storage/features/domain/usecases/invoice/create_invoice_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/get_incoice_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/get_invoices_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/update_invoice_usecase.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/utils/state_status.dart';

class InvoiceController extends GetxController{
  Rx<InvoiceTableEntity> invoiceTable = new InvoiceTableEntity().obs;
  var invoices = List<InvoiceEntity>().obs;
  Rx<InvoiceEntity> invoice = new InvoiceEntity().obs;
  Rx<ResponseEntity> response = new ResponseEntity().obs;
  var updateInvoiceState = StateStatus.INITIAL.obs;
  var getInvoicesState = StateStatus.INITIAL.obs;
  var getInvoiceState = StateStatus.INITIAL.obs;
  var createInvoiceState = StateStatus.INITIAL.obs;

  updateInvoice(String id,String body){
    updateInvoiceState.value = StateStatus.LOADING;
    UpdateInvoiceUseCase updateInvoiceUseCase = Get.find();
    updateInvoiceUseCase.call(Params(body: body,id: id)).then((response) {
      if(response.isRight) {
        updateInvoiceState.value = StateStatus.SUCCESS;
        invoice.value = response.right;
      } else if(response.isLeft){
        updateInvoiceState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  getInvoices(String param){
   getInvoicesState.value = StateStatus.LOADING;
    GetInvoicesUseCase getInvoicesUseCase = Get.find();
    getInvoicesUseCase.call(Params(body: param)).then((response){
      if(response.isRight) {
        getInvoicesState.value = StateStatus.SUCCESS;
        invoiceTable.value = response.right;
        // if(pageIndex == 1) {
        //   // invoices.clear();
        //   // invoices=invoiceTable.value.invoices;
        // } else
          invoices.addAll(invoiceTable.value.invoices);
      } else
        if(response.isLeft){
          ServerFailure failure = response.left;
          // if(failure.errorCode == 0 || failure.errorCode == 1)
          //   Get.snackbar(
          //       'error'.tr, 'noInternetTxt'.tr, duration: Duration(seconds: 3),
          //       colorText: Colors.black);
          getInvoicesState.value = StateStatus.ERROR;
        }
    });
  }
  getInvoice(String id){
    getInvoiceState.value = StateStatus.LOADING;
    GetInvoiceUseCase getInvoiceUseCase = Get.find();
    getInvoiceUseCase.call(Params(body: id)).then((response){
      if(response.isRight) {
        getInvoiceState.value = StateStatus.SUCCESS;
        invoice.value = response.right;
      } else
        if(response.isLeft){
          getInvoiceState.value = StateStatus.ERROR;
          // errorAction(response.left);
        }
    });
  }
  createInvoice(String body,ValueChanged<bool> parentAction){
    createInvoiceState.value = StateStatus.LOADING;
    CreateInvoiceUseCase createInvoiceUseCase = Get.find();
    createInvoiceUseCase.call(Params(body: body)).then((response) {
      if(response.isRight) {
        createInvoiceState.value = StateStatus.SUCCESS;
        Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: response.right.message.invoice).then((value){
          parentAction(true);
        });
        // MyAlertDialog.show(["Successfully Added"],true,response.right.message.invoice.toString());
      }
      else
        if(response.isLeft){
          ServerFailure failure = response.left;
          createInvoiceState.value = StateStatus.ERROR;
          if(failure.errorCode == 422)
            MyAlertDialog.show(["Server error".tr], true);
          else
            errorAction(response.left);
        }
    });
  }
  reset(){
    // invoices.clear();
    invoiceTable = new InvoiceTableEntity().obs;
    invoice = new InvoiceEntity().obs;
    response = new ResponseEntity().obs;
  }
  errorAction(ServerFailure failure){
    String errorMessage="Server error".tr;
    if(failure.errorCode == 0 || failure.errorCode == 1)
      errorMessage = 'noInternetTxt'.tr;
    MyAlertDialog.show([errorMessage], true);
  }
}