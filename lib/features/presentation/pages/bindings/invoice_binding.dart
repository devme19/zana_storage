import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/invoice/create_invoice_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/get_incoice_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/get_invoices_usecase.dart';
import 'package:zana_storage/features/domain/usecases/invoice/update_invoice_usecase.dart';

class InvoiceBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetInvoiceUseCase>(() => GetInvoiceUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetInvoicesUseCase>(() => GetInvoicesUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<CreateInvoiceUseCase>(() => CreateInvoiceUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<UpdateInvoiceUseCase>(() => UpdateInvoiceUseCase(
      repository: Get.find()
    ));
  }

}