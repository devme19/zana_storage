import 'package:get/get.dart';
import 'package:zana_storage/features/data/datasources/local/zana_storage_local_datasource.dart';
import 'package:zana_storage/features/data/datasources/remote/zana_storage_remote_datasource.dart';
import 'package:zana_storage/features/data/repositories/zana_storage_repository_impl.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';
import 'package:zana_storage/features/domain/usecases/dashboard/get_dashboard_usecase.dart';
import 'package:zana_storage/features/domain/usecases/logout/log_out_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_qr_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_logs_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_products_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/manage_product_usecase.dart';

class ProductBiding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetProductByQrUseCase>(() => GetProductByQrUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<ManageProductUseCase>(() => ManageProductUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetProductLogsUseCase>(() => GetProductLogsUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetProductsUseCase>(() => GetProductsUseCase(
        repository: Get.find()
    ));


  }

}