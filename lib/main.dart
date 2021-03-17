import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/bindings/main_binding.dart';
import 'package:zana_storage/utils/messages.dart';

import 'features/presentation/controllers/setting_controller.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUS = true;
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      child:
      Obx(()=>GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffeeeeee),
          // Define the default brightness and colors.
          // brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(67, 103, 203,1),
          // accentColor: Colors.cyan[600],

          // Define the default font family.
          // fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(

              bodyText2: TextStyle(
                  fontSize: settingController.fontSize.value,
                  color: Colors.black87

              ),
              bodyText1: TextStyle(
                  fontSize: settingController.fontSize.value,
                  color: Colors.black87
              ),
              subtitle1: TextStyle(
                  fontSize: settingController.fontSize.value,
                  color: Colors.black87
              ),
              button: TextStyle(
                fontSize: settingController.fontSize.value,
                // color: Colors.black54
              ),
              caption: TextStyle(
                fontSize: settingController.fontSize.value,
                // color: Colors.black54
              )
            // bodyText2: TextStyle(fontSize: 19.0),
            // button: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),

          ),
        ),
        translations: Messages(),
        locale: isUS?Locale('en','US'):Locale('fa','IR'),
        fallbackLocale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        initialRoute: ZanaStorageRoutes.splashPage,
        getPages: ZanaStorage.pages,
        initialBinding: MainBinding(),
      ),)
    );

  }

  @override
  void initState() {
    super.initState();
    GetStorage box = GetStorage();
    if(box.hasData('isUS'))
      isUS = box.read('isUS');
  }
}
