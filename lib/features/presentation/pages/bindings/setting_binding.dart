import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/setting/get_locale_usecase.dart';
import 'package:zana_storage/features/domain/usecases/setting/save_locale_usecase.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SaveLocaleUseCase>(() => SaveLocaleUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetLocaleUseCase>(() => GetLocaleUseCase(
        repository: Get.find()
    ));
  }

}