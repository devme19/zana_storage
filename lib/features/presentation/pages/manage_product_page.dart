

import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:zana_storage/features/presentation/controllers/product_controller.dart';
import 'package:zana_storage/features/presentation/pages/add_invoice_page.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/utils/state_status.dart';
class ManageProductPage extends StatefulWidget {
  ManageProductPage();
  @override
  _ManageProductPageState createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  ProductEntity2 product;
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ProductController productController = Get.put(ProductController());
  FocusNode descriptionText = new FocusNode();


  bool isDec = false;
  String id;
  List<Widget> list;
  List<Widget> manageList;

  int pageIndex = 1;
  String parameters;
  ScrollController _controller = ScrollController();
  ScrollController _mainController = ScrollController();
  String productName ="";
  _mainScrollListener() {

  }
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // if(productController.productLog.value.logs.length == 0)
      //   pageIndex-=1;
      if(productController.productLog.value.logs.length!=0)
        pageIndex = int.parse(productController.productLog.value.page)+1;
      parameters = "page=$pageIndex&pagesize=$pageSize&id=$id";
      productController.getProductLogs(parameters);
      // setState(() {
      //   message = "reach the bottom";
      // });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      _mainController.animateTo(
          _mainController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    }
    if (_controller.position.userScrollDirection ==
        ScrollDirection.reverse){
      _mainController.animateTo(
          _mainController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //
    //   // setState(() {
    //   //   message = "reach the top";
    //   // });
    // }
  }

  @override
  void initState() {
    super.initState();
    product = Get.arguments;
    id = product.id.toString();
    parameters = "page=$pageIndex&pagesize=$pageSize&id=$id";
    _controller.addListener(_scrollListener);
    productController.getProductLogs(parameters);
    if(product!= null)
      productName = product.title;
    list = new List();
    manageList = new List();
  }


  @override
  void dispose() {
    super.dispose();
    productController.productLogs.clear();
    productController.manageProductLog.value.data = null;

    // productController.manageProductLog.value.data = null;
    // productController.productLog.value.logs = null;
    // productController.productLog.value.product = null;
    // descriptionText.dispose();
  }
  onResponse(bool res){
    if(res){
      quantityController.clear();
      descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Manage Product'.tr),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Get.back();
          },
        ),
      ),
      body:
      Obx(()=>SingleChildScrollView(
        controller: _mainController,
        child: Column(children: [
          Form(
            key: _formKey,
            child:
            Container(
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16.0),
              child:
              Column(children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius+3))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Image.network(product.image!=null?product.image:"",fit: BoxFit.cover,)),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.grey.withOpacity(0.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Expanded(child: AutoSizeText(productController.productTitle.value,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,))
                            ],),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("In Stock".tr +" : "+productController.inStock.value),
                  ],),
                SizedBox(height: 8,),
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(descriptionText);
                    },
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value.isEmpty){
                        return 'field is empty'.tr;
                      }
                      else
                      if(int.parse(value)>int.parse(productController.inStock.value)&& isDec)
                        return 'resource is low'.tr;
                      return null;
                    },
                    decoration:
                    InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Quantity'.tr,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                        ),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        )
                    ),
                  ),
                ),
                Expanded(child: TextFormField(
                  textInputAction: TextInputAction.done,
                  focusNode: descriptionText,
                  controller: descriptionController,
                  maxLines: null,
                  decoration:
                  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Description'.tr,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: const BorderSide(color: Color.fromRGBO(67, 103, 203,1), width: 1.5),

                      ),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      )
                  ),
                ),),
                Expanded(child: Container(
                  height: 70,
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:2,
                              child:
                              RaisedButton(
                                  padding: EdgeInsets.only(top: 20,bottom: 20),
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(borderRadius),
                                    // side: BorderSide(color: Colors.grey)
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                    isDec = false;
                                    if(_formKey.currentState.validate()){
                                      Map<String, dynamic> jsonMap = {
                                        'change_qty': quantityController.text,
                                        'description': descriptionController.text,
                                        'productId': id,
                                        'status': '1',
                                      };
                                      String body = json.encode(jsonMap);
                                      productController.manageProduct(body, id,onResponse);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Increase'.tr,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
                                      Icon(Icons.arrow_upward,color: Colors.white,)
                                    ],
                                  )
                              ),
                            ),
                            Expanded(flex:1,child:
                            productController.manageProductState.value == StateStatus.LOADING?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ):
                            productController.manageProductState.value == StateStatus.SUCCESS?
                            AnimatedOpacity(
                                opacity: productController.checkVisible.value ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: Icon(Icons.check,color: Colors.green,)):
                            productController.manageProductState.value == StateStatus.ERROR?
                            Icon(Icons.error_outline,color: Colors.red,):Container(),),
                            Expanded(
                              flex: 2,
                              child:
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(borderRadius),
                                    // side: BorderSide(color: Colors.grey)
                                  ),
                                  color: Colors.red,
                                  padding: EdgeInsets.only(top: 20,bottom: 20),
                                  onPressed: productController.inStock.value == "0"?null:() {
                                    isDec = true;
                                    if(_formKey.currentState.validate()){

                                      if(int.parse(quantityController.text)>int.parse(productController.inStock.value))
                                        _formKey.currentState.setState(() {
                                        });
                                      else{
                                        Map<String, dynamic> jsonMap = {
                                          'change_qty': quantityController.text,
                                          'description': descriptionController.text,
                                          'productId': id,
                                          'status': '0',
                                        };
                                        String body = json.encode(jsonMap);
                                        productController.manageProduct(body, id,onResponse);
                                      }

                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Decrease'.tr,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
                                      Icon(Icons.arrow_downward,color: Colors.white,)
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),)
              ],
              ),
            ),
          ),
          productController.productLogs.length!=0 || productController.manageProductLog.value.product !=null?Container(
            margin: EdgeInsets.only(left: 16,right: 16,bottom: 16.0),
            child:
            Container(
              height: Get.height,
              padding: EdgeInsets.only(left:16.0,right: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              child: ListView(
                  controller: _controller,
                  children: createLogs(productController.manageProductLog.value)
              ),
            ),
          ):Container()

        ],),
      ))

    );
  }
  // Widget inStock(){
  //   productName = productController.productTitle.value;
  //   // product.quantity = int.parse(productController.inStock.value);
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //   Row(
  //     children: [
  //       Text(productName,style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),
  //     ],
  //   ),
  //   Text("In Stock".tr +" : "+productController.inStock.value),
  //   ],);
  // }
  List<Widget> createLogs(ManageProductEntity manageProduct){
    int ind=0;
    List<Widget> tempList = new List();
    List<Widget> tempList2 = new List();
    if(manageProduct.data != null && productController.flag.value){
      tempList2.addAll(manageList);
      manageList = new List();

      manageList.add(
          Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  // right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  // left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  // top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                )),
            // padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Text(manageProduct.data.created_at),
                      ],
                    )),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Text(manageProduct.data.change_qty.toString(),textAlign: TextAlign.right,),
                      ),
                      Container(
                        width: 35,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: manageProduct.data.status == "1" ? Colors.green : Colors.red,
                        ),
                        child: Icon(
                          manageProduct.data.status == "1"
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          color: Colors.white,
                        ),
                      ),
                      // SizedBox(width: 24.0,)
                    ],
                  ),
                ),
                // Expanded(
                //     flex: 4,
                //     child: Row(
                //       children: [
                //         Text(manageProduct.data.created_at),
                //       ],
                //     )),
                // Expanded(
                //   flex: 2,
                //   child: Row(
                //     children: [
                //       Expanded(flex:3,child: Padding(
                //         padding: const EdgeInsets.only(right:8.0),
                //         child: Text(manageProduct.data.change_qty.toString(),textAlign: TextAlign.right,),
                //       )),
                //       Expanded(
                //         flex: 2,
                //         child:
                //         Container(
                //           width: 35,
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(4),
                //             color: manageProduct.data.status == "1" ? Colors.green : Colors.red,
                //           ),
                //           child: Icon(
                //             manageProduct.data.status == "1"
                //                 ? Icons.arrow_upward_rounded
                //                 : Icons.arrow_downward_rounded,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //       // SizedBox(width: 24.0,)
                //     ],
                //   ),
                // ),





                // log.status == "1" ? Icon(Icons.arrow_upward,color: Colors.green):
                // Icon(Icons.arrow_downward,color: Colors.red)
              ],
            ),
          )
      //   Container(
      //   height: 60,
      //   decoration: BoxDecoration(
      //     border: Border(
      //       bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
      //       // right: BorderSide(width: 1.0, color: Colors.grey.shade300),
      //       // left: BorderSide(width: 1.0, color: Colors.grey.shade300),
      //       // top: BorderSide(width: 1.0, color: Colors.grey.shade300),
      //     )
      //   ),
      //   // padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
      //   child:
      //
      //     Row(
      //     children: [
      //   Expanded(flex:4,child:
      //   Row(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left:16.0),
      //         child: Text(manageProduct.data.created_at),
      //       ),
      //     ],
      //   )),
      //   Expanded(
      //     flex: 1,
      //     child:
      //
      //     Row(
      //       children: [
      //         Expanded(flex:3,child: Padding(
      //           padding: const EdgeInsets.only(right:8.0),
      //           child: Text(manageProduct.data.change_qty.toString(),textAlign: TextAlign.right,),
      //         )),
      //         Expanded(
      //           flex:2,
      //           child: Container(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(4),
      //               color: manageProduct.data.status == "1" ?Colors.green:Colors.red,
      //             ),
      //
      //             child: Icon(manageProduct.data.status == "1"?Icons.arrow_upward_rounded:Icons.arrow_downward_rounded,color: Colors.white,),
      //           ),
      //         ),
      //
      //
      //       ],
      //     ),
      //   )
      //   // log.status == "1" ? Icon(Icons.arrow_upward,color: Colors.green):
      //   // Icon(Icons.arrow_downward,color: Colors.red)
      //   ],
      // ),
      // ),
      );
      productController.flag.value = false;
      manageList.addAll(tempList2);
      // productController.manageProductLog.value.data = null;
    }
      else {
          list = new List();
          for (var log in productController.productLogs) {
            ind++;
            list.add(
                Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey.shade100),
                    // right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                    // left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                    // top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  )),
              // padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [

                  Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(log.created_at),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Text(log.change_qty.toString(),textAlign: TextAlign.right,),
                        ),
                        Container(
                          width: 35,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: log.status == "1" ? Colors.green : Colors.red,
                          ),
                          child: Icon(
                            log.status == "1"
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: Colors.white,
                          ),
                        ),
                        // SizedBox(width: 24.0,)
                      ],
                    ),
                  ),
                  // log.status == "1" ? Icon(Icons.arrow_upward,color: Colors.green):
                  // Icon(Icons.arrow_downward,color: Colors.red)
                ],
              ),
            ));
          }
    }
      tempList.addAll(manageList);
      tempList.addAll(list);
    return tempList;
  }
}
