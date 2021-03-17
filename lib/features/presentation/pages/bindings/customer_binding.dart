import 'package:get/get.dart';
import 'package:zana_storage/features/data/datasources/local/zana_storage_local_datasource.dart';
import 'package:zana_storage/features/data/datasources/remote/zana_storage_remote_datasource.dart';
import 'package:zana_storage/features/data/repositories/zana_storage_repository_impl.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';
import 'package:zana_storage/features/domain/usecases/customer/add_customer_usecase.dart';
import 'package:zana_storage/features/domain/usecases/customer/get_customers_usecase.dart';
import 'package:zana_storage/features/domain/usecases/customer/update_customer_usecase.dart';

class CustomerBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetCustomersUseCase>(() => GetCustomersUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<UpdateCustomerUseCase>(() => UpdateCustomerUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<AddCustomerUseCase>(() => AddCustomerUseCase(
      repository: Get.find()
    ));
  }

}