import 'package:get/get.dart';
import 'package:zana_storage/features/domain/usecases/product/get_product_by_id_usecase.dart';
import 'package:zana_storage/features/presentation/controllers/product_detail_controller.dart';

class DetailProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<GetProductByIdUseCase>(() => GetProductByIdUseCase(
      repository: Get.find()
    ));
  }
}