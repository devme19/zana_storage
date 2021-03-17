import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/presentation/controllers/login_controller.dart';
import 'package:zana_storage/features/presentation/controllers/setting_controller.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isUS = true;
  var locale;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    settingController.getLocale();
    // settingController.saveLocale(true);
    // emailController.text = 'meysam88@yahoo.com';
    // passwordController.text = '10203040';
  }

  @override
  Widget build(BuildContext context) {
    // locale = Locale('en', 'US');
    // Get.updateLocale(locale);
    final node = FocusScope.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: [
          Obx(()=>
              Container(
                color: settingController.isUs.value?Colors.transparent:Colors.transparent,
                child: FlatButton(onPressed: (){
                  locale = Locale('en', 'US');
                  Get.updateLocale(locale);
                  setState(() {
                    isUS = true;
                  });
                  settingController.saveLocale(isUS);
                }, child: Text('EN',style: TextStyle(color: settingController.isUs.value?Colors.white:Colors.grey.shade500),)),
              ),),
          Obx(()=>
              Container(
                color: settingController.isUs.value?Colors.transparent:Colors.transparent,
                child: FlatButton(onPressed: (){
                  locale = Locale('fa', 'IR');
                  Get.updateLocale(locale);
                  setState(() {
                    isUS = false;
                  });
                  settingController.saveLocale(isUS);
                }, child: Text('کوردی',style: TextStyle(color: settingController.isUs.value?Colors.grey.shade500:Colors.white))),
              ),)
        ],
      ),
      body:
      Form(
        key: _formKey,
        child:
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: 
          SingleChildScrollView(
            reverse: true,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                          height: 150,
                          child: Image(image: AssetImage('asset/images/ic_launcher.png'))),
                      SizedBox(height: 40,),
                      Text('Zana Storage',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    ],
                  ),
                ),
                SizedBox(height: 100,),
                TextFormField(
                  controller: emailController,
                  onEditingComplete: () => node.nextFocus(),
                  validator: (value){
                    if(value.isEmpty){
                      return 'emailHintText'.tr;
                    }
                    else if(GetUtils.isEmail(value))
                          return null;
                          else return 'invalidEmailError'.tr;
                  },
                  decoration:
                  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email'.tr,
                      prefixIcon: Icon(Icons.email),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide: BorderSide.none

                      ),
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide:BorderSide.none
                      )
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  validator: (value){
                    if(value.isEmpty){
                      return 'passwordEmpty'.tr;
                    }
                    else
                      return null;
                  },
                  decoration:
                  InputDecoration(
                      labelText: 'passwordHintText'.tr,
                      filled: true,
                      fillColor: Colors.white,

                      prefixIcon: Icon(Icons.vpn_key_sharp),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: (){
                          setState(() {
                            _obscureText = !_obscureText;
                            print(_obscureText);
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide: BorderSide.none

                      ),
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide:BorderSide.none
                      )
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(
                      child:
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              // side: BorderSide(color: Colors.grey.shade200)
                          ),
                          color: Colors.green,
                          padding: EdgeInsets.only(top: 20,bottom: 20),
                          onPressed:() {
                            if (_formKey.currentState.validate()) {
                              // Get.snackbar('processingDataTxt'.tr, '');
                              Map<String, dynamic> jsonMap = {
                                'email': emailController.text,
                                'password': passwordController.text,
                              };
                              String body = json.encode(jsonMap);
                              loginController.login(body);
                            }
                          },
                          child:
                          Obx(()=>Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('loginBtnTxt'.tr,style: TextStyle(color: Colors.white),),
                              loginController.loading.value?Container(margin:EdgeInsets.only(left: 15),width:20,height: 20,child: CircularProgressIndicator(backgroundColor: Colors.white,)):Container()
                            ],
                          ))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
