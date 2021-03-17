import 'package:get/get.dart';
import 'package:zana_storage/features/data/datasources/local/zana_storage_local_datasource.dart';
import 'package:zana_storage/features/data/datasources/remote/zana_storage_remote_datasource.dart';
import 'package:zana_storage/features/data/repositories/zana_storage_repository_impl.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';
import 'package:zana_storage/features/domain/usecases/dashboard/get_dashboard_usecase.dart';
import 'package:zana_storage/features/domain/usecases/init/clear_init_usecase.dart';
import 'package:zana_storage/features/domain/usecases/init/init_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_qr_usecase.dart';
import 'package:zana_storage/features/domain/usecases/user/get_user_info_usecase.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ZanaStorageRemoteDataSource>(ZanaStorageRemoteDatasourceImpl());
    Get.put<ZanaStorageLocalDataSource>(ZanaStorageLocalDataSourceImpl());
    Get.put<ZanaStorageRepository>(ZanaStorageRepositoryImpl(
      remoteDataSource: Get.find(),
      localDataSource: Get.find()
    ));

    Get.put<GetUserInfoUseCase>(GetUserInfoUseCase(
        repository: Get.find()
    ));
    Get.put<InitUseCase>(InitUseCase(
      repository: Get.find()
    ));
    Get.put<ClearInitUseCase>(ClearInitUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetDashboardUseCase>(() => GetDashboardUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetProductByQrUseCase>(() => GetProductByQrUseCase(
        repository: Get.find()
    ));
  }

}