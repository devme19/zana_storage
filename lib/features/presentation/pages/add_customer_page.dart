import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/data/model/customer_model.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/presentation/controllers/customer_controller.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';

class AddCustomerPage extends StatelessWidget {
  ValueChanged<CustomerEntity> parentAction;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  CustomerController customerController;
  double marginTop = 20.0;
  bool boolValue = false;
  final _formKey = GlobalKey<FormState>();
  AddCustomerPage({this.parentAction
  }){
    if(Get.arguments != null)
      boolValue = Get.arguments;
  }

  Future<bool> back(){
    if(parentAction!=null)
      parentAction(customerController.addedCustomer.value);
    Get.back();
  }
  clearEdits(bool value){
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    addressController.clear();
    postalCodeController.clear();
    phoneController.clear();
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    customerController = Get.put(CustomerController());
    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Customer'.tr),
        ),
        body:

        Form(
          key: _formKey,
          child:
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            ),
            margin: EdgeInsets.all(16.0),
            child:
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // SizedBox(height: 100,),
                      Container(
                        child:
                        TextFormField(

                          controller: firstNameController,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          validator: (value){
                            if(value.isEmpty){
                              return 'first name is empty'.tr;
                            }
                            else
                              return null;
                          },
                          onEditingComplete: () => node.nextFocus(),
                          decoration:
                          InputDecoration(
                              labelText: 'First Name'.tr,
                              filled: true,
                              fillColor: Colors.white,
                            // prefixIcon: Icon(Icons.description),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),
                      Container(
                        child:
                        TextFormField(
                          controller: lastNameController,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          validator: (value){
                            if(value.isEmpty){
                              return 'last name is empty'.tr;
                            }
                            else
                              return null;
                          },
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.description),
                            labelText: 'Last Name'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.description),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),
                      Container(
                        child:
                        TextFormField(
                          controller: mobileController,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value.isEmpty){
                              return 'mobile number is empty'.tr;
                            }
                            else
                              return null;
                          },
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.description),
                            labelText: 'Mobile'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.description),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),
                      Container(
                        child:
                        TextFormField(
                          controller: phoneController,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.description),
                            labelText: 'Phone Number'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.description),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),
                      Container(
                        child:
                        TextFormField(
                          controller: addressController,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.description),
                            labelText: 'Address'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.description),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),
                      Container(
                        child:
                        TextFormField(
                          controller: postalCodeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.description),
                            labelText: 'Postal Code'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: Icon(Icons.description),

                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                              ),
                              border:OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              )
                            // border: null,
                          ),
                        ),
                      ),
                      SizedBox(height: marginTop,),

                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex:2,
                      child:
                      Obx(()=>
                          RaisedButton(
                          color: Colors.green,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            // side: BorderSide(color: Colors.yellowAccent)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customerController.addCustomerState.value?
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                                ):AutoSizeText('Save'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),

                              ],
                            ),
                          ),onPressed:customerController.addCustomerState.value?null: (){
                        if (_formKey.currentState.validate()){
                          Map<String, dynamic> jsonMap = {
                            'name': firstNameController.text,
                            'family': lastNameController.text,
                            'mobile': mobileController.text,
                            'address': addressController.text,
                            'postal_code': postalCodeController.text,
                            'phone': phoneController.text,
                          };
                          String body = json.encode(jsonMap);
                          if(!boolValue)
                            customerController.addCustomer(body,clearEdits);
                          else
                            customerController.addCustomer(body,null);
                        }
                      }),)
                    ),
                    // parentAction!=null?
                    parentAction!=null?
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(flex:1,child: Container()),
                          Expanded(
                            flex: 2,
                            child: RaisedButton(
                                color: Colors.redAccent.shade200,
                                shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(borderRadius),
                                  // side: BorderSide(color: Colors.yellowAccent)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: AutoSizeText(
                                    'Temporary',
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),onPressed: (){
                              if (_formKey.currentState.validate()){
                                Map<String, dynamic> jsonMap = {
                                  'name': firstNameController.text,
                                  'family': lastNameController.text,
                                  'mobile': mobileController.text,
                                  'address': addressController.text,
                                  'postal_code': postalCodeController.text,
                                  'phone': phoneController.text,
                                };
                                if(parentAction!=null)
                                  parentAction(CustomerModel.fromJson(jsonMap));
                                Get.back();
                              }
                            }),
                          )
                        ],
                      ),
                    ): Container(),
                    // :Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
