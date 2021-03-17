import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/usecases/setting/get_locale_usecase.dart';
import 'package:zana_storage/features/domain/usecases/setting/save_locale_usecase.dart';

class SettingController extends GetxController{
  RxBool error = false.obs;
  RxBool isUs = true.obs;
  final String FONT_SIZE =  "fontSize";
  SaveLocaleUseCase saveLocaleUseCase;
  GetLocaleUseCase getLocaleUseCase;
  GetStorage box = GetStorage();
  RxDouble fontSize = 11.0.obs;
  saveLocale(bool isUS){
    error.value = false;
    saveLocaleUseCase = Get.find();
    saveLocaleUseCase.call(Params(boolValue: isUS)).then((response){
      if(response.isLeft)
        error.value = true;
      if(response.isRight)
        isUs.value = isUS;
    });

  }
  getLocale(){
    error.value = false;
    getLocaleUseCase = Get.find();
    getLocaleUseCase.call(NoParams()).then((response){
      if(response.isRight) {
        isUs.value = response.right;
        if(isUs.value == null) {
          isUs.value = true;
          saveLocaleUseCase = Get.find();
          saveLocaleUseCase.call(Params(boolValue: true)).then((value){});
        }
      }
      else if(response.isLeft)
        error.value = true;
    });
  }
  setFontSize(double size){
    box.write(FONT_SIZE, size);
    fontSize.value = size;
  }
  getFontSize(){
    fontSize.value = box.read(FONT_SIZE);
  }

}