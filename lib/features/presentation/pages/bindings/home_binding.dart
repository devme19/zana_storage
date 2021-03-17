import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/dashboard/get_dashboard_usecase.dart';
import 'package:zana_storage/features/domain/usecases/logout/log_out_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_qr_usecase.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetProductByQrUseCase>(() => GetProductByQrUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<LogOutUseCase>(() => LogOutUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetDashboardUseCase>(() => GetDashboardUseCase(
        repository: Get.find()
    ));
  }

}