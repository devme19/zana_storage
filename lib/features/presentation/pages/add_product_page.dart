import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:get/get.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/presentation/controllers/add_product_controller.dart';
import 'package:zana_storage/features/presentation/controllers/init_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/features/presentation/widgets/drop_down.dart';

class AddProductPage extends GetView<AddProductController>{

  TextEditingController titleController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController discountController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController skuController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  List<DropDownItem> categoryList = new List();
  List<DropDownItem> currencyList = new List();
  List<DropDownItem> taxList = new List();
  String selectedCategory,selectedCurrency,selectedTax;
  DropdownWidget categoryDropDown,currencyDropDown,taxDropDown;
  InitController initController = Get.put(InitController());
  ProductEntity3 product;
  String currencyEdit,categoryEdit,taxEdit;
  bool isEdit = false;
  bool isEditClear = false;

  _selectedCategory(String selected){
    selectedCategory = selected;
  }
  _selectedCurrency(String selected){
    selectedCurrency = selected;
  }
  _selectedTax(String selected){
    selectedTax = selected;
  }
  AddProductPage(){
    initController.getInit(_getInit);
    if(Get.arguments!=null)
      {
        product = Get.arguments;
        isEdit = true;
        titleController.text = product.product.title;
        priceController.text = product.product.price;
        discountController.text = product.product.discount.toString();
            quantityController.text = product.product.quantity.toString();
            skuController.text = product.product.sku;
        descriptionController.text = product.product.description;
      }
  }
  _getInit(InitEntity initEntity){
    if(initEntity!=null) {
      for (var item in initEntity.options[0].categories) {
          categoryList.add(DropDownItem(title: item.title, value: item.id.toString()));
          if(isEdit && item.id == product.product.cat_id) {
            selectedCategory = item.id.toString();
            categoryEdit = item.title;
          }

      }
      for (var item in initEntity.options[0].currencies) {
        currencyList
            .add(DropDownItem(title: item.title, value: item.id.toString()));
        if(isEdit && item.id == product.product.currency.id) {
          selectedCurrency = item.id.toString();
          currencyEdit = item.title;
        }
      }
      for (var item in initEntity.options[0].taxes) {
        taxList.add(DropDownItem(title: item.title, value: item.id.toString()));
        if(isEdit && item.id == product.product.tax_id) {
          selectedTax = item.id.toString();
          taxEdit = item.title;
        }
      }
      categoryDropDown = DropdownWidget(
        items: categoryList,
        parentAction: _selectedCategory,
        index: 2,
        currentItem: categoryEdit,
      );
      taxDropDown = DropdownWidget(
        items: taxList,
        parentAction: _selectedTax,
        index: 3,
        currentItem: taxEdit,
      );
      currencyDropDown = DropdownWidget(
        items: currencyList,
        parentAction: _selectedCurrency,
        index: 4,
        currentItem: currencyEdit,
      );
    }
  }
  showModal(){
    Get.bottomSheet(
      Container(
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child:
                Icon(
                  Icons.photo_camera,
                  size: 50,
                  color: Colors.blue,
                ),
                onTap: () {
                  Get.back();
                  _pickImage(ImageSource.camera);
                },

              ),
            ),
            Container(
                margin: EdgeInsets.all(8.0),
              width: 2,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: InkWell(
                child: Icon(
                  Icons.photo_library,
                  size: 50,
                  color: Colors.green,
                ),
                onTap: () {
                  Get.back();
                  _pickImage(ImageSource.gallery);

                } ,

              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    Get.toNamed(ZanaStorageRoutes.pickImage,arguments: selected).then((value) async{

      if(value!=null) {
        print("before:"+value.lengthSync().toString());
        int quality = 100;
        compressedFile = await FlutterNativeImage.compressImage(value.path,
            quality: quality, percentage: 100);
        print("after:"+compressedFile.lengthSync().toString());

        do {
          if(compressedFile.lengthSync()>2000000) {
            quality-=10;
                compressedFile =
                    await FlutterNativeImage.compressImage(
                        value.path,
                        quality: quality,
                        percentage: 100);
                print("after:"+compressedFile.lengthSync().toString());
              } else
            break;
        } while (true);
        print("after:"+compressedFile.lengthSync().toString());
        controller.upLoadImage(compressedFile,isEdit?product.product.id.toString():"");
      }
    });
  }
  final _formKey = GlobalKey<FormState>();
  double marginTop = 20.0;
  File compressedFile;
  ImageCache image;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body:
        Obx(()=>Form(
          key: _formKey,
          child:
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16.0),
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
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(isEdit && (product.product.image ==  null || product.product.image == '')&&!controller.imagePicked.value)
                            showModal();
                          else
                          if(isEdit && isEditClear){
                            showModal();
                          }
                          else
                          if(!controller.imagePicked.value && !isEdit)
                            showModal();
                        },
                        child:
                        Container(
                          width: Get.width-64,
                          // color: Colors.white,
                          // width: double.infinity,
                          height: Get.width/2,
                          // margin: EdgeInsets.all(16.0),
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
                              border: Border.all(color: Colors.grey.shade300,width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(borderRadius+3))
                          ),
                          child:
                          ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child:
                            Stack(
                              children: [

                                Row(
                                  children: [
                                    Expanded(child: !controller.imagePicked.value?
                                        isEdit&&isEditClear?
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image_outlined,size: 80,),
                                      ],
                                    ):isEdit?product.product.image==null||product.product.image==''?
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image_outlined,size: 80,),
                                          ],
                                        ):
                                        Image.network(product.product.image,fit: BoxFit.cover,):
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image_outlined,size: 80,),
                                          ],
                                        ):
                                    Image.file(controller.imageFile,fit: BoxFit.cover)),
                                  ],
                                ),
                                controller.uploadImageState.value == StateStatus.LOADING?
                                Align(
                                  alignment: Alignment.center,
                                  child:
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Opacity(
                                          opacity: 0.8,
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: EdgeInsets.all(3),
                                              decoration: new BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
                                                value: controller.uploadProgress.value/100,
                                              )
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(controller.uploadProgress.toString()+"%",style: TextStyle(color: Colors.white),),
                                      ),
                                    ],

                                  ),
                                ):controller.uploadImageState.value == StateStatus.ERROR?
                                Align(
                                  alignment: Alignment.center,
                                  child:
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Opacity(
                                          opacity: 0.8,
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: EdgeInsets.all(3),
                                              decoration: new BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                              child: InkWell(
                                                child: Icon(Icons.error_outline,color: Colors.red,size: 35,),
                                                onTap: ()=>controller.upLoadImage(compressedFile,isEdit?product.product.id.toString():""),
                                              )
                                          ),
                                        ),
                                      ),
                                    ],

                                  ),
                                ):controller.imagePicked.value||(isEdit && product.product.image!=null)?
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: (){
                                      controller.clearImage();
                                      if(isEdit)
                                        isEditClear = true;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(borderRadius),
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          color: Colors.grey.withOpacity(0.8),
                                          child: Icon(Icons.delete_forever,size: 35,color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ):Container(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      color: Colors.grey,
                                      child: Row(children: [
                                        Icon(Icons.camera_alt_outlined,color: Colors.black,),
                                        Text('Pick an image',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                      ],),
                                    ),
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
                SizedBox(height: marginTop,),
                initController.initStatus.value == StateStatus.SUCCESS ?Row(
                  children: [
                    Expanded(child:categoryDropDown),
                  ],
                ):Container(),
                SizedBox(height: marginTop,),
                initController.initStatus.value == StateStatus.SUCCESS?
                Row(
                  children: [
                    Expanded(child: currencyDropDown),
                  ],
                ):Container(),
                SizedBox(height: marginTop,),
                initController.initStatus.value == StateStatus.SUCCESS ?
                Row(
                  children: [
                    Expanded(child:taxDropDown),
                  ],
                ):Container(),
                SizedBox(height: marginTop,),
                Divider(),
                SizedBox(height: marginTop,),
                Container(
                  child:
                  TextFormField(

                    controller: skuController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value.isEmpty){
                        return 'sku is empty'.tr;
                      }
                      else
                        return null;
                    },
                    onEditingComplete: () => node.nextFocus(),
                    decoration:
                    InputDecoration(
                        labelText: 'Sku'.tr,
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

                    controller: titleController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value.isEmpty){
                        return 'title is empty'.tr;
                      }
                      else
                        return null;
                    },
                    onEditingComplete: () => node.nextFocus(),
                    decoration:
                    InputDecoration(
                        labelText: 'Title'.tr,
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
                    controller: priceController,
                    maxLines: null,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value.isEmpty){
                        return 'price is empty'.tr;
                      }
                      else
                        return null;
                    },
                    onEditingComplete: () => node.nextFocus(),
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                        labelText: 'Price'.tr,
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
                    controller: quantityController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value.isEmpty){
                        return 'quantity is empty'.tr;
                      }
                      else
                        return null;
                    },
                    onEditingComplete: () => node.nextFocus(),
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                        labelText: 'Quantity'.tr,
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
                    controller: discountController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                        labelText: 'Discount'.tr,
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
                    controller: descriptionController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => node.nextFocus(),
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                        labelText: 'Description'.tr,
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
                Row(
                  children: [
                    Expanded(
                      flex:2,
                      child:
                      RaisedButton(
                          color: Colors.green,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            // side: BorderSide(color: Colors.yellowAccent)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (controller.addProductState.value == StateStatus.LOADING)||
                                    (controller.updateProductState.value == StateStatus.LOADING)?
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                                ):
                                AutoSizeText('Save'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),

                              ],
                            ),
                          ),onPressed: (controller.addProductState.value == StateStatus.LOADING)||
                          (controller.updateProductState.value == StateStatus.LOADING)?null:(){
                        List<String> errorMessages = new List();
                        bool validateError = false;
                        if(selectedCategory == null) {
                          errorMessages
                              .add('Select a category');
                          validateError = true;
                        }
                        if(selectedCurrency == null) {
                          errorMessages
                              .add('Select a currency');
                          validateError = true;
                        }
                        if(selectedTax == null) {
                          errorMessages
                              .add('Select a tax');
                          validateError = true;
                        }
                        if(validateError) MyAlertDialog.show(errorMessages,false);
                        if (_formKey.currentState.validate()){
                          // String s = UploadImageResponse.fromJson(controller.json).data;
                          Map<String, dynamic> jsonMap;
                          if(isEdit){
                            if(controller.uploadImageResponse!=null)
                              jsonMap = {
                                'category_id': selectedCategory,
                                'currency_id': selectedCurrency,
                                'tax_id': selectedTax,
                                'title': titleController.text,
                                'price': priceController.text,
                                'sku': skuController.text,
                                'quantity': quantityController.text,
                                'discount': discountController.text==""?"0":discountController.text,
                                'description': descriptionController.text,
                                'image': controller.uploadImageResponse.data,
                              };
                            else
                              jsonMap = {
                                'category_id': selectedCategory,
                                'currency_id': selectedCurrency,
                                'tax_id': selectedTax,
                                'title': titleController.text,
                                'price': priceController.text,
                                'sku': skuController.text,
                                'quantity': quantityController.text,
                                'discount': discountController.text==""?"0":discountController.text,
                                'description': descriptionController.text,
                              };
                            String body = json.encode(jsonMap);
                            controller.updateProduct(body,product.product.id.toString());
                          }else{
                            jsonMap = {
                              'category_id': selectedCategory,
                              'currency_id': selectedCurrency,
                              'tax_id': selectedTax,
                              'title': titleController.text,
                              'price': priceController.text,
                              'sku': skuController.text,
                              'quantity': quantityController.text,
                              'discount': discountController.text==""?"0":discountController.text,
                              'description': descriptionController.text,
                              'image_code': controller.uploadImageResponse!=null?controller.uploadImageResponse.data:"",

                            };
                            String body = json.encode(jsonMap);
                            controller.addProduct(body,clearForm);
                          }
                        }
                      }),
                    ),
                    // :Container(),
                  ],
                ),
              ],
            ),
          ),
        ))
    );
  }
  clearForm(bool clear){
    titleController.clear();
    priceController.clear();
    discountController.clear();
    quantityController.clear();
    skuController.clear();
    descriptionController.clear();
    categoryDropDown = DropdownWidget(
      items: categoryList,
      parentAction: _selectedCategory,
      index: 2,
    );
    taxDropDown = DropdownWidget(
      items: taxList,
      parentAction: _selectedTax,
      index: 3,
    );
    currencyDropDown = DropdownWidget(
      items: currencyList,
      parentAction: _selectedCurrency,
      index: 4,
    );
  }
}



