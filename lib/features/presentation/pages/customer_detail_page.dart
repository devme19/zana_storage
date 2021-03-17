import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/presentation/controllers/customer_controller.dart';
// ignore: must_be_immutable
class CustomerDetailPage extends StatefulWidget {
  CustomerEntity customerEntity;
  CustomerDetailPage({this.customerEntity});

  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  bool edit = true;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();
  CustomerController customerController = Get.put(CustomerController());
  _onEdit(bool error){
    if(!error)
      setState(() {
        edit=!edit;
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController.text = widget.customerEntity.name;
    lastNameController.text = widget.customerEntity.family;
    mobileNumberController.text = widget.customerEntity.mobile;
    phoneNumberController.text = widget.customerEntity.phone;
    addressController.text = widget.customerEntity.address;
    postalCodeController.text = widget.customerEntity.postalCode;
    customerController.customer.value = widget.customerEntity;
  }
  @override
  Widget build(BuildContext context) {
    // customerEntity = Get.arguments;
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail".tr),
      ),
      body:
          widget.customerEntity!=null?
      Container(

        padding: EdgeInsets.all(16),
        child:
        Container(
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
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(borderRadius),topRight:Radius.circular(borderRadius))
                        ),

                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('First Name'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.name??"",textAlign: TextAlign.end,):TextFormField(
                              controller: firstNameController,
                              style: TextStyle(color: Colors.black),
                              onEditingComplete: () => node.nextFocus(),
                              // maxLines: null,

                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('Last Name'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.family??"",textAlign: TextAlign.end,):TextFormField(
                              controller: lastNameController,
                              style: TextStyle(color: Colors.black),
                              onEditingComplete: () => node.nextFocus(),
                              // maxLines: null,

                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        color: Colors.grey.shade100,
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('Mobile Number'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.mobile??"",textAlign: TextAlign.end,):TextFormField(
                              controller: mobileNumberController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.black),
                              onEditingComplete: () => node.nextFocus(),
                              // maxLines: null,

                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('Phone Number'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.phone??"",textAlign: TextAlign.end,):TextFormField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.black),
                              onEditingComplete: () => node.nextFocus(),
                              // maxLines: null,

                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        color: Colors.grey.shade100,
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('Address'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.address??"",textAlign: TextAlign.end,):TextFormField(
                              controller: addressController,
                              keyboardType: TextInputType.streetAddress,
                              style: TextStyle(color: Colors.black),
                              maxLines: null,
                              onEditingComplete: () => node.nextFocus(),

                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(flex:1,child: Text('Postal Code'.tr)),

                            Expanded(flex:1,child: edit?Text(customerController.customer.value.postalCode??"",textAlign: TextAlign.end,):TextFormField(
                              controller: postalCodeController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),

                              // maxLines: null,

                            )),
                          ],
                        ),
                      ),
                    ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child:
                      Obx(()=>RaisedButton(
                          color: Colors.green,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.yellowAccent)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customerController.updateCustomerState.value?
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                                ):Text(edit?'Edit'.tr:'Save'.tr,style: TextStyle(color: Colors.white),),

                              ],
                            ),
                          ),onPressed: customerController.updateCustomerState.value?null:(){
                        if(!edit)
                          save();
                        else
                          setState(() {
                            edit = !edit;
                          });

                      }),)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ):Container(),
    );
  }
  save(){
    Map<String, dynamic> jsonMap = {
      'name': firstNameController.text,
      'family': lastNameController.text,
      'address':addressController.text,
      'postal_code':postalCodeController.text,
      'mobile':mobileNumberController.text,
      'phone':phoneNumberController.text,
    };
    String body = json.encode(jsonMap);
    customerController.updateCustomer(body, widget.customerEntity.id.toString(),_onEdit);
  }
  Widget row(bool isGray,String title,String value){
    return
      Container(
      padding: EdgeInsets.only(top: edit?35:22,bottom: edit?35:22,left: 22,right: 22),
      color: isGray? Colors.grey.shade100:Colors.white,
      child: Row(
        children: [
          Expanded(flex:1,child: Text(title)),

          Expanded(flex:1,child: edit?Text(value,textAlign: TextAlign.end,):TextFormField(

            style: TextStyle(color: Colors.black),
            maxLines: null,

            decoration: InputDecoration(

              hintText: value,

            ),
          )),
        ],
      ),
    );
  }
}
