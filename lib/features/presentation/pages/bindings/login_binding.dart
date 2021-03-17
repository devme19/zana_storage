import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/login/login_usecase.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(
        repository: Get.find()
    ));
  }

}