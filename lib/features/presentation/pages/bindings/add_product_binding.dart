import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/product/add_product_usecase.dart';
import 'package:zana_storage/features/domain/usecases/product/update_product_usecase.dart';
import 'package:zana_storage/features/presentation/controllers/add_product_controller.dart';

class AddProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController());
    Get.lazyPut<AddProductUseCase>(() => AddProductUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<UpdateProductUseCase>(() => UpdateProductUseCase(
      repository: Get.find()
    ));
  }

}