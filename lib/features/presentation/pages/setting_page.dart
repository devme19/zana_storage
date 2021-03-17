import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/features/presentation/controllers/setting_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/home_page.dart';
// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  bool isUs = false;
  GetStorage box;
  var locale;
  double borderRadius = 5.0;
  SettingController settingController;
  @override
  Widget build(BuildContext context) {
    settingController = Get.put(SettingController());
    settingController.getLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text("Zana Storage"),
        centerTitle: true,
      ),
      body:
      Obx(()=>
          Container(
              // color: Colors.grey.shade200,
              margin: EdgeInsets.all(0.0),
              child:
              Column(
                children: [
                  Container(
                    // height: 60,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                    ),
                    child: Column(children: [
                      Row(children: [
                        Text('Language'.tr,style: TextStyle(fontWeight: FontWeight.bold),)
                      ],),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('English'.tr),
                                Checkbox(value: settingController.isUs.value, onChanged:(value){
                                  if(value == true) {
                                    isUs = true;
                                    locale = Locale('en', 'US');
                                    Get.updateLocale(locale);
                                    settingController.saveLocale(isUs);
                                  }
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('Kurdish'.tr),
                                Checkbox(value: !settingController.isUs.value, onChanged:(value){
                                  if(value == true) {
                                    isUs = false;
                                    locale = Locale('fa', 'IR');
                                    Get.updateLocale(locale);
                                    settingController.saveLocale(isUs);
                                  }
                                }),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],)
                  ),
                  Divider(height: 5,),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Font Size",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(settingController.fontSize.toInt().toString()),
                          ],
                        ),
                        FlutterSlider(
                          values: [settingController.fontSize.value],
                          max: 20,
                          min: 10,
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            settingController.setFontSize(lowerValue);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 5,),
                  Container(
                    // height: 60,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                      ),
                      child: InkWell(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:16.0,bottom: 16.0),
                              child: Text('LogOut',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        onTap: (){
                          GetStorage box = GetStorage();
                          box.remove('token');
                          Get.offAllNamed(ZanaStorageRoutes.loginPage);
                        },
                      )
                  ),

                ],
              )
          ),
      )
    );
  }
}


