import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/usecases/init/clear_init_usecase.dart';
import 'package:zana_storage/features/domain/usecases/init/init_usecase.dart';
import 'package:zana_storage/features/domain/usecases/user/get_user_info_usecase.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/home_page.dart';
import 'package:zana_storage/features/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GetUserInfoUseCase getUserInfoUseCase = Get.find();
  InitUseCase initUseCase = Get.find();
  ClearInitUseCase clearInitUseCase = Get.find();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
          child: Container(
            child: SpinKitFoldingCube(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            )
          ),
        ),
      );
  }

  @override
  void initState(){
    super.initState();
    GetStorage box = GetStorage();
    print(box.read('token'));
    clearInitUseCase.call(NoParams()).then((value) {});
    Future.delayed(Duration(milliseconds: 500), () {
      if(box.hasData('token')) {
        initUseCase.call(NoParams()).then((value) {
        });
        getUserInfoUseCase.call(Params(boolValue: true)).then((value) {
        });
        Get.offAndToNamed(ZanaStorageRoutes.homePage);
      }else
        Get.offAndToNamed(ZanaStorageRoutes.loginPage);
      // Get.offAll(HomePage()) : Get.offAll(LoginPage());

    });
  }
}

