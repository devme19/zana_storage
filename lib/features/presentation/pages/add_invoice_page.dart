import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:get/get.dart';
import 'package:zana_storage/features/presentation/controllers/init_controller.dart';
import 'package:zana_storage/features/presentation/controllers/invoice_controller.dart';
import 'package:zana_storage/features/presentation/controllers/product_controller.dart';
import 'package:zana_storage/features/presentation/pages/add_customer_page.dart';
import 'package:zana_storage/features/presentation/pages/bindings/customer_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/product_binding.dart';
import 'package:zana_storage/features/presentation/pages/manage_product_page.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/features/presentation/widgets/drop_down.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:zana_storage/utils/state_status.dart';

import 'customers_page.dart';

class AddInvoicePage extends StatefulWidget {
  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> with SingleTickerProviderStateMixin{

  CustomerEntity selectedCustomer;
  List<SelectedProductItem> selectedProducts = new List();
  List<DropDownItem> paymentTypeList = new List();
  List<DropDownItem> statusList = new List();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ProductController productController;
  InvoiceController invoiceController = Get.put(InvoiceController());
  InitController initController = Get.put(InitController());
  String paymentType,paymentStatus;
  double spaceBetween = 15;
  double padding = 16;
  AnimationController _animationController;
  DropdownWidget paymentDropDown,statusDropDown;
  final _formKey = GlobalKey<FormState>();

  _paymentType(String pType){
    paymentType = pType;
  }
  _paymentStatus(String pStatus){
    paymentStatus = pStatus;
  }
  _selectedCustomer(CustomerEntity customer){
    if(customer.name != null) {
      selectedCustomer = customer;
      setState(() {});
    }
  }
  _selectedProduct(ProductEntity2 product){
    bool exist = false;
      for(var item in selectedProducts) {
         // item.totalPrice += item.quantity*int.parse(item.product.price);
      if (item.product.id == product.id) {
        exist = true;
        if (item.product.quantity > item.quantity) {
          item.blink = true;
          item.isMax = false;
          item.quantity++;
          item.totalPrice += double.parse(item.product.price);
          break;
        }
        else{
          item.isMax = true;
        }

      }
    }
    if(!exist) {
      selectedProducts.add(SelectedProductItem(product: product, quantity: product.quantity == 0?0:1,totalPrice: double.parse(product.price),isMax: product.quantity<1?true:false));
    }
    setState(() {

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    productController.reset();
    // paymentDropDown.selectedItem = null;
    // clearForm();
    super.dispose();

  }
  clearForm(bool clear){
    descriptionController.clear();
    selectedProducts.clear();
    discountController.clear();
    selectedCustomer = null;
    // paymentDropDown.reset();
    // statusDropDown.reset();
    paymentDropDown=DropdownWidget(items: paymentTypeList,parentAction: _paymentType,);
    statusDropDown=DropdownWidget(items: statusList,parentAction: _paymentStatus,);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();

    initController.getInit(_getPaymentType);
    statusList.add(DropDownItem(title: "Not Paid".tr,value: "0"));
    statusList.add(DropDownItem(title: "Paid".tr,value: "1"));
    _animationController =
    new AnimationController(vsync: this, duration: Duration(milliseconds:500 ));
    _animationController.repeat(reverse: true);
    paymentDropDown=DropdownWidget(items: paymentTypeList,parentAction: _paymentType,index: 0,);
    statusDropDown=DropdownWidget(items: statusList,parentAction: _paymentStatus,index: 1,);
  }
  _getPaymentType(InitEntity initEntity){
    if(initEntity != null)
      for (var item in initEntity.options[0].payment_types) {
        print(item.title);
        paymentTypeList
            .add(DropDownItem(title: item.title, value: item.id.toString()));
      }
    else {
      paymentTypeList.add(DropDownItem(title: "Credit Card".tr, value: "1"));
      paymentTypeList.add(DropDownItem(title: "Cash".tr, value: "2"));
      paymentTypeList.add(DropDownItem(title: "Check".tr, value: "3"));
    }
    setState(() {
    });

  }
  @override
  Widget build(BuildContext context) {
    productController = Get.put(ProductController());

    // Obx(()=>_selectedProduct(product));
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Invoice'.tr),

      ),
      body:
        Container(
          padding: EdgeInsets.all(0),
          child:
          SingleChildScrollView(
            child:
            Container(
              // color: Colors.grey.shade200,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(left:16.0,right: 16.0,top: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text('Select Customer'.tr,style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          selectedCustomer == null?
                          Expanded(
                            child:
                            Container(
                              margin: EdgeInsets.all(16),
                              child: RaisedButton(
                                  color: Colors.blue.shade400,
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderRadius),
                                      // side: BorderSide(color: Colors.grey.shade300)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Customers'.tr,style: TextStyle(color: Colors.white)),
                                  ),onPressed: (){
                                Get.to(CustomerPage(parentAction: _selectedCustomer,isCustomerPage: false,),binding: CustomerBinding());
                                // Get.toNamed(ZanaStorageRoutes.customerPag e);
                                // Get.to(Customers(parentAction: _selectedCustomer,isCustomerPage: false),binding: CustomerBinding());
                              }),
                            ),
                          ):
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: ListTile(
                                onTap: (){
                                  Get.to(CustomerPage(parentAction: _selectedCustomer,isCustomerPage: false,),binding: CustomerBinding());
                                },
                                title:
                                Container(

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.7,
                                          blurRadius: 1,
                                          offset: Offset(0, 0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                                  ),
                                  padding: EdgeInsets.only(left:32,bottom: 16,top: 16.0),
                                  child:
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(selectedCustomer.family+" "+selectedCustomer.name),
                                              ],
                                            ),
                                            SizedBox(height: 25,),
                                            Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(flex:1,
                                                    child: Icon(Icons.location_on_outlined)),
                                                Expanded(flex:10,
                                                    child: Text(selectedCustomer.address!=null ?
                                                    selectedCustomer.address:""
                                                      ,
                                                    )),

                                              ],
                                            ),
                                            SizedBox(height: 25,),
                                            Row(
                                              children: [
                                                Expanded(flex:1,child: Icon(Icons.phone_android_rounded)),
                                                Expanded(flex:10,child: Text(selectedCustomer.mobile!=null?selectedCustomer.mobile:"")),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Icon(Icons.chevron_right)
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:
                            Container(
                              margin: EdgeInsets.all(16),
                              child: RaisedButton(
                                  color: Colors.blue.shade400,
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderRadius),
                                      // side: BorderSide(color: Colors.blue.shade400)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('New Customer'.tr,style: TextStyle(color: Colors.white),),
                                  ),onPressed: (){
                                Get.to(AddCustomerPage(parentAction: _selectedCustomer,),binding: CustomerBinding());
                                // Get.toNamed(ZanaStorageRoutes.customerPag e);
                                // Get.to(Customers(parentAction: _selectedCustomer,isCustomerPage: false),binding: CustomerBinding());
                              }),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  margin: EdgeInsets.only(left:16.0,right: 16.0),
                  padding: EdgeInsets.all(padding),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [

                          Text('Select Product'.tr,style: TextStyle(fontWeight: FontWeight.bold),),


                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      // margin: EdgeInsets.only(left: 16.0,right: 16.0),
                      child: Row(
                        children: [

                          Expanded(
                            flex: 3,
                            child:
                            Container(
                              margin: EdgeInsets.all(16),
                              child: RaisedButton(
                                  color: Colors.blue.shade400,
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderRadius),
                                      // side: BorderSide(color: Colors.grey.shade300)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Products'.tr,style: TextStyle(color: Colors.white)),
                                  ),onPressed: (){
                                productController.products.clear();
                                Get.to(ProductDialog(parentAction: _selectedProduct,),binding: ProductBiding()).then((value) {
                                 });
                              }),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(()=>
                                IconButton(
                              iconSize: 40,
                              icon: productController.getProductByQrState.value==StateStatus.LOADING?CircularProgressIndicator():Icon(Icons.qr_code_scanner_outlined),
                              onPressed: () async {
                                if (await Permission.camera.request().isGranted) {
                                  String cameraScanResult = await scanner.scan();
                                  productController.getProductByQr(
                                      cameraScanResult, _selectedProduct);
                                }
                              },
                            ),)
                          ),

                        ],
                      ),
                    ),
                    selectedProducts.length != 0?
                    Container(
                        color:Colors.white,
                        child: Column(
                            children: createProductsList()
                        )

                    )
                        : Container(),
                  ],),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  margin: EdgeInsets.only(left:16.0,right: 16.0),
                  // padding: EdgeInsets.all(32),
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [

                            Text('Payment'.tr,style: TextStyle(fontWeight: FontWeight.bold),),


                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: paymentTypeList.length!=0?paymentDropDown:Container()),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Expanded(child: statusDropDown),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  margin: EdgeInsets.only(left:16.0,right: 16.0),
                  // padding: EdgeInsets.all(32),
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [

                            Text('Price'.tr,style: TextStyle(fontWeight: FontWeight.bold),),


                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 70,
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child:
                        Row(
                          children: [
                            Expanded(flex:9,child: Text("Discount".tr),),
                            Expanded(flex: 2,
                              child: TextFormField(
                                controller: discountController,
                                onFieldSubmitted: (term){
                                  setState(() {
                                  });
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                // decoration: InputDecoration(
                                //   // prefixIcon: Icon(Icons.money_off_rounded),
                                //   // border: const OutlineInputBorder(),
                                // ),
                              ),
                            ),
                            Expanded(flex:1,child: Text("%"),),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: createPriceTable(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  // padding: EdgeInsets.all(32),
                  margin: EdgeInsets.only(left:16.0,right: 16.0),
                  // padding: EdgeInsets.all(32),
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child:
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Description'.tr,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                            borderSide: BorderSide.none

                        ),
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                            borderSide:BorderSide.none
                        )
                      // border: null,
                    ),
                  ),
                ),
                SizedBox(height: spaceBetween,),
                Container(
                  margin: EdgeInsets.only(left:16.0,right: 16.0,bottom: 16.0),
                  // padding: EdgeInsets.all(32),
                  // padding: EdgeInsets.only(left: 5,right: 5),
                  child: Row(
                    children: [

                      Expanded(
                        child:
                        Obx(()=>RaisedButton(
                            color: Colors.green,
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              // side: BorderSide(color: Colors.yellowAccent)
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                invoiceController.createInvoiceState.value == StateStatus.LOADING?
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                                ):Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('Save'.tr,style: TextStyle(color: Colors.white),),
                                ),

                              ],
                            ),onPressed:invoiceController.createInvoiceState.value == StateStatus.LOADING?null: (){
                          List<String> errorTitles = new List();
                          if(selectedCustomer == null)
                            errorTitles.add("Select a customer".tr);
                          if(selectedProducts.length == 0)
                            errorTitles.add("Select a product".tr);
                          if(paymentType==null)
                            errorTitles.add("Select payment Type".tr);
                          if(paymentStatus==null)
                            errorTitles.add("Select payment status".tr);
                          for(var item in selectedProducts) {
                            if(item.quantity>item.product.quantity || item.quantity == 0)
                              errorTitles.add(
                                  item.product.title+" "+ "quantity is low".tr);
                          }
                          if(errorTitles.length == 0) {
                            List<Map<String, dynamic>> pjsonMap =
                            new List();
                            for (int i = 0;
                            i < selectedProducts.length;
                            i++) {
                              pjsonMap.add(ProductToPost(
                                  id: selectedProducts[i]
                                      .product
                                      .id
                                      .toString(),
                                  discount:
                                  discountController.text,
                                  quantity: selectedProducts[i]
                                      .quantity
                                      .toString())
                                  .toJson());
                            }
                            String discount = "0";
                            if (discountController
                                .text.isNumericOnly)
                              discount = discountController.text;
                            Map<String, dynamic> jsonMap = {
                              'customer_type':selectedCustomer.id!=null? "system":"Manual",
                              'paid': paymentStatus,
                              'payment_type': paymentType,
                              'discount': discount,
                              'description':
                              descriptionController.text,
                              'status': "1",
                              'products': pjsonMap,
                              'customer': CustomerToPost(
                                id: selectedCustomer.id.toString(),
                                name: selectedCustomer.name,
                                family: selectedCustomer.family,
                                mobile: selectedCustomer.mobile,
                                address: selectedCustomer.address,
                                postalCode:
                                selectedCustomer.postalCode,
                                phone: selectedCustomer.phone,
                              ).toJson()
                            };

                            String body = json
                                .encode(jsonMap); // print(body);

                            invoiceController.createInvoice(body,clearForm);
                          }
                          else{
                            MyAlertDialog.show(errorTitles,false);
                          }
                        })),
                      ),

                    ],
                  ),
                ),
              ],),
            ),
          ),
        )

    );
  }

  List<Widget> createProductsList(){
    List<Widget> list = new List();
    list.add(Divider());
    String itemTotalPrice;
    for(int i=0 ;i<selectedProducts.length;i++) {
      if(selectedProducts[i].product.quantity != 0)
      itemTotalPrice = (double.parse(selectedProducts[i].product.price)*selectedProducts[i].quantity).toString()+" "+selectedProducts[i].product.symbol;
      else itemTotalPrice="0 "+selectedProducts[i].product.symbol;
      list.add(
          ListTile(
            title: Container(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: 80,
                        height: 80,
                        child:selectedProducts[i].product.image !=null? Image.network(selectedProducts[i].product.image)
                            :Icon(Icons.image_search,size: 30,)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex:1,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(selectedProducts[i].product.title,)),
                                ],
                              )),
                          // Expanded(
                          //   flex:1,
                          //     child: Row(
                          //       children: [
                          //
                          //
                          //         Expanded(
                          //             flex: 5,
                          //             child: Text(selectedProducts[i].product.price +
                          //                 " " +
                          //                 selectedProducts[i].product.symbol)),
                          //       ],
                          //     )),
                          Expanded(
                              flex:1,
                              child:
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(flex:1,
                                    child:
                                    Container(
                                      height: double.infinity,
                                      decoration: new BoxDecoration(
                                        color: Colors.orange.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: selectedProducts[i].quantity > 1
                                          ? GestureDetector(
                                          child:
                                          Icon(Icons.remove,),
                                          onTap: () {
                                            setState(() {
                                              selectedProducts[i].quantity--;
                                              selectedProducts[i].totalPrice -= double.parse(
                                                  selectedProducts[i].product.price);
                                              selectedProducts[i].isMax = false;
                                            });
                                          })
                                          : GestureDetector(
                                          child: Icon(Icons.delete_forever),
                                          onTap: () {
                                            setState(() {
                                              selectedProducts[i].isMax = false;
                                              selectedProducts[i].totalPrice -= double.parse(
                                                  selectedProducts[i].product.price);
                                              selectedProducts.removeAt(i);
                                            });
                                          }),
                                    ),
                                  ),

                                  Expanded(flex:3,child:  selectedProducts[i].blink?FadeTransition(
                                    opacity: _animationController,
                                    child: Text(
                                      selectedProducts[i].product.quantity ==0?"0/0":selectedProducts[i].quantity.toString()+"/"+selectedProducts[i].product.quantity.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ): Text(
                                    selectedProducts[i].product.quantity ==0?"0/0": selectedProducts[i].quantity.toString()+"/"+selectedProducts[i].product.quantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if (selectedProducts[i].product.quantity >
                                              selectedProducts[i].quantity) {
                                            selectedProducts[i].quantity++;
                                            selectedProducts[i].totalPrice += double.parse(
                                                selectedProducts[i].product.price);
                                          } else
                                            selectedProducts[i].isMax = true;
                                        });
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        decoration: new BoxDecoration(
                                          color: Colors.orange.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                  Expanded(flex:1,child: selectedProducts[i].isMax
                                      ? Text(
                                    "Max",
                                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 13),
                                    textAlign: TextAlign.end,

                                  )
                                      : Container())
                                ],
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(children: [
                                // Expanded(
                                //     flex: 1, child: Icon(Icons.add_chart)),
                                Expanded(
                                    flex: 5,
                                    child: Text(itemTotalPrice,style:TextStyle(fontSize: 15,fontWeight: FontWeight.w800))),
                                // Expanded(flex:1,child: IconButton(icon: Icon(Icons.wrap_text,),onPressed: (){
                                //   Get.to(ManageProductPage(),arguments: selectedProducts[i].product,binding: ProductBiding()).then((value) {
                                //   });
                                // },))
                              ],))
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Column(
                  //     children: [
                  //       IconButton(icon: Icon(Icons.cancel), onPressed: (){
                  //         setState(() {
                  //            selectedProducts.removeAt(i);
                  //         });
                  //       }),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),

          )
      );


      // list.add(
      //   ListTile(
      //     title: Container(
      //       height: 200,
      //       child: Row(
      //         children: [
      //           Expanded(
      //             flex: 3,
      //             child: Container(
      //                 width: 180,
      //                 height: 180,
      //                 child:selectedProducts[i].product.image !=null? Image.network(selectedProducts[i].product.image)
      //             :Icon(Icons.image_search,size: 30,)),
      //           ),
      //           Expanded(
      //             flex: 4,
      //             child: Container(
      //               padding: EdgeInsets.all(16),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Expanded(
      //                     flex:1,
      //                       child: Row(
      //                         children: [
      //                           SizedBox(
      //                             width: 11,
      //                           ),
      //                           Expanded(
      //                               flex: 1,
      //                               child: Text(selectedProducts[i].product.title,)),
      //                         ],
      //                       )),
      //                   Expanded(
      //                     flex:1,
      //                       child: Row(
      //                         children: [
      //                           Expanded(
      //                               flex: 1, child: Icon(Icons.money)),
      //                           Expanded(
      //                               flex: 5,
      //                               child: Text(selectedProducts[i].product.price +
      //                                   " " +
      //                                   selectedProducts[i].product.symbol)),
      //                         ],
      //                       )),
      //                   Expanded(
      //                     flex:1,
      //                       child:
      //                       Row(
      //                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         // crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Expanded(flex:1,
      //                               child:
      //                               Container(
      //                                 height: double.infinity,
      //                                 decoration: new BoxDecoration(
      //                                   color: Colors.orange.shade100,
      //                                   shape: BoxShape.circle,
      //                                 ),
      //                                 child: selectedProducts[i].quantity > 1
      //                                     ? GestureDetector(
      //                                     child:
      //                                     Icon(Icons.remove,),
      //                                     onTap: () {
      //                                       setState(() {
      //                                         selectedProducts[i].quantity--;
      //                                         selectedProducts[i].totalPrice -= double.parse(
      //                                             selectedProducts[i].product.price);
      //                                         selectedProducts[i].isMax = false;
      //                                       });
      //                                     })
      //                                     : GestureDetector(
      //                                     child: Icon(Icons.delete_forever),
      //                                     onTap: () {
      //                                       setState(() {
      //                                         selectedProducts[i].isMax = false;
      //                                         selectedProducts[i].totalPrice -= double.parse(
      //                                             selectedProducts[i].product.price);
      //                                         selectedProducts.removeAt(i);
      //                                       });
      //                                     }),
      //                               ),
      //                           ),
      //
      //                          Expanded(flex:3,child:  selectedProducts[i].blink?FadeTransition(
      //                            opacity: _animationController,
      //                            child: Text(
      //                                selectedProducts[i].product.quantity ==0?"0/0":selectedProducts[i].quantity.toString()+"/"+selectedProducts[i].product.quantity.toString(),
      //                                textAlign: TextAlign.center,
      //                            ),
      //                          ): Text(
      //                              selectedProducts[i].product.quantity ==0?"0/0": selectedProducts[i].quantity.toString()+"/"+selectedProducts[i].product.quantity.toString(),
      //                              textAlign: TextAlign.center,
      //                          ),),
      //                           Expanded(
      //                             flex: 1,
      //                             child: GestureDetector(
      //                               onTap: (){
      //                                 setState(() {
      //                                   if (selectedProducts[i].product.quantity >
      //                                       selectedProducts[i].quantity) {
      //                                     selectedProducts[i].quantity++;
      //                                     selectedProducts[i].totalPrice += double.parse(
      //                                         selectedProducts[i].product.price);
      //                                   } else
      //                                     selectedProducts[i].isMax = true;
      //                                 });
      //                               },
      //                               child: Container(
      //                                 height: double.infinity,
      //                                 decoration: new BoxDecoration(
      //                                   color: Colors.orange.shade100,
      //                                   shape: BoxShape.circle,
      //                                 ),
      //                                 child: Icon(Icons.add),
      //                               ),
      //                             ),
      //                           ),
      //                           Expanded(flex:1,child: selectedProducts[i].isMax
      //                               ? Text(
      //                             "Max",
      //                             style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 13),
      //                             textAlign: TextAlign.end,
      //
      //                           )
      //                               : Container())
      //                         ],
      //                       )
      //                   ),
      //                   Expanded(
      //                     flex: 1,
      //                       child: Row(children: [
      //                     Expanded(
      //                         flex: 1, child: Icon(Icons.add_chart)),
      //                     Expanded(
      //                         flex: 5,
      //                         child: Text(itemTotalPrice)),
      //                         // Expanded(flex:1,child: IconButton(icon: Icon(Icons.wrap_text,),onPressed: (){
      //                         //   Get.to(ManageProductPage(),arguments: selectedProducts[i].product,binding: ProductBiding()).then((value) {
      //                         //   });
      //                         // },))
      //                   ],))
      //                 ],
      //               ),
      //             ),
      //           ),
      //           // Expanded(
      //           //   flex: 1,
      //           //   child: Column(
      //           //     children: [
      //           //       IconButton(icon: Icon(Icons.cancel), onPressed: (){
      //           //         setState(() {
      //           //            selectedProducts.removeAt(i);
      //           //         });
      //           //       }),
      //           //     ],
      //           //   ),
      //           // )
      //         ],
      //       ),
      //     ),
      //
      //   )
      //     );
      if(i+1 != selectedProducts.length)
        list.add(Container(height: 1,color: Colors.grey.shade200,));
      selectedProducts[i].blink = false;
    }
    return list;
  }
  List<Widget> createPriceTable(){
    List<Widget> list = new List();
    List<String> symbol = new List();
    List<double> totalPrice = new List();
    int index = 0;
    for(int i=0; i<selectedProducts.length; i++) {
      if(symbol.contains(selectedProducts[i].product.symbol))
        continue;
      totalPrice.add(selectedProducts[i].totalPrice);
        for (int j = i + 1; j < selectedProducts.length; j++)
          if (selectedProducts[i].product.symbol == selectedProducts[j].product.symbol) {
          totalPrice[index] += selectedProducts[j].totalPrice;
        }
        if(!symbol.contains(selectedProducts[i].product.symbol)) {
          symbol.add(selectedProducts[i].product.symbol);

          list.add(Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100)
              ),
              padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
              child:
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex:3,child: Text("Total Price".tr)),
                  Expanded(flex:1,
                    child: Text(totalPrice[index].toString()+" "+selectedProducts[i].product.symbol,style: TextStyle(
                        decoration: discountController.text.isNumericOnly?TextDecoration.lineThrough:TextDecoration.none,
                      color: discountController.text.isNumericOnly?Colors.grey:Colors.black,
                    ),textAlign: TextAlign.center,),
                  ),
                  discountController.text.isNumericOnly?Expanded(flex:1,child: Text(((totalPrice[index]-totalPrice[index]*int.parse(discountController.text)/100).toStringAsFixed(0))+" "+selectedProducts[i].product.symbol,textAlign: TextAlign.center,)):Container()
                ],
              )
          ));
        }

      index++;
    }
    return list;
  }

}
// ignore: must_be_immutable


class ProductDialog extends StatefulWidget {
  final ValueChanged<ProductEntity2> parentAction;
  ProductDialog({this.parentAction});
  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  ProductEntity2 selectedProduct;
  TextEditingController searchController = new TextEditingController();
  ProductController productController;
  int pageIndex = 1;
  String parameters,searchParams;
  ScrollController _controller = ScrollController();

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if(productController.productTable.value.products.length!=0)
        pageIndex = productController.productTable.value.page+1;
      parameters = "page=$pageIndex&pagesize=$pageSize";
      productController.getProducts(parameters);
      // setState(() {
      //   message = "reach the bottom";
      // });
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
    _controller.addListener(_scrollListener);
    parameters = "page=$pageIndex&pagesize=$pageSize";
    productController = Get.put(ProductController());

  }
  Widget _back(){
    Get.back();
    return Container();
  }
  _onPressConnectionError(bool error){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    productController.getProducts(parameters);
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Products'.tr),
        ),
        body:
        Obx(()=>
        Container(
          // margin: EdgeInsets.only(top: 30),
          child:
          Column(
            children: [
              Card(
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: searchController,
                      textInputAction: TextInputAction.done,
                      decoration: new InputDecoration(
                          hintText: 'Search by title'.tr, border: InputBorder.none),
                      onEditingComplete: (){
                        searchParams = "&filterby=title&keywords=${searchController.text}&page=$pageIndex&pagesize=$pageSize";
                        productController.products.clear();
                        productController.getProducts(searchParams);
                      },
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {

                      searchController.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: productController.product.value.id!=null?_back():
                productController.products.length!=0 ?
                Container(
                  child:
                  MediaQuery.removePadding(context: context,
                    child:                   ListView.builder(
                      controller: _controller,
                      itemCount: productController.products.length,
                      itemBuilder: (context,index){
                        return
                          InkWell(
                            child: Card(
                              child: Container(
                                height: 140,
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(flex:2,
                                        child: productController.products[index].image !=null?
                                        Image.network(productController.products[index].image,fit: BoxFit.cover,):
                                        Container(child: Icon(Icons.image_search,size: 30,),)
                                    ),
                                    Expanded(flex:3,child:
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(productController.products[index].title,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(productController.products[index].price+" "+productController.products[index].symbol,
                                                ),
                                          ),
                                        ],),
                                    )
                                    ),
                                    Expanded(flex:1,child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(productController.products[index].quantity.toString(),
                                          textAlign: TextAlign.end,
                                          ),
                                    ),)

                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              selectedProduct = productController.products[index];
                              widget.parentAction(selectedProduct);
                              Get.back();
                            },
                          );
                      },
                    ),
                    removeTop: true,)
                ):
                productController.getProductsState.value == StateStatus.LOADING?
                Center(child: SpinKitDualRing(
                  color: Colors.blue.shade200,
                  size: 25.0,
                )):productController.getProductsState.value == StateStatus.ERROR?
                ConnectionError(parentAction: _onPressConnectionError,):
                Center(child: Text("Not Found".tr),
              ),
              )
            ],
          ),
        )
        )
      );
  }
  onSearchTextChanged(String text) {
    if (text.isEmpty) {
      pageIndex = 1;
      parameters = "page=$pageIndex&pagesize=$pageSize";
      productController.products.clear();
      productController.getProducts(parameters);
    }
  }
}

class SelectedProductItem{
  ProductEntity2 product;
  int quantity;
  bool isMax = false;
  double totalPrice;
  bool blink = false;
  SelectedProductItem({
    this.product,
    this.quantity,
    this.totalPrice,
    this.isMax
});
}


class ProductToPost{
  String id;
  String discount;
  String quantity;
  ProductToPost({this.id,this.discount,this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount'] = this.discount;
    data['cart_quantity'] = this.quantity;
    return data;
  }
}
class CustomerToPost{
  String name;
  String family;
  String mobile;
  String address;
  String postalCode;
  String phone;
  String id;
  CustomerToPost({
    this.id,
    this.name,
    this.family,
    this.mobile,
    this.address,
    this.postalCode,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['family'] = this.family;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    return data;
  }
}