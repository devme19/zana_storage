import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/presentation/controllers/init_controller.dart';
import 'package:zana_storage/features/presentation/controllers/product_detail_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/helper/item.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  String id;

  List<Item> categories,currencies,taxes;
  String category,currency,tax;
  ProductDetailPage(){
    id = Get.arguments.toString();
    controller.getProduct(id);
  }
  _onPressConnectionError(bool refresh){
    controller.getProduct(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Obx(()=>controller.getProductState.value == StateStatus.LOADING?
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: SpinKitDualRing(
              color: Colors.blue.shade200,
              size: 25,
            ),
          ),
        ),
      ):
      controller.getProductState.value == StateStatus.SUCCESS?
      controller.responseEntity.value.product.image==null || controller.responseEntity.value.product.image == ''?
          Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 1,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey.shade300,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            margin: EdgeInsets.all(16.0),
              child: Column(
                 children: [
                  Expanded(child: details()),
                ],
              )):
      SingleChildScrollView(
        child: 
        Container(
          height: Get.mediaQuery.orientation == Orientation.landscape ? 2.1*Get.height:Get.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    Positioned(
                      top:Get.width/2-60,
                      width: Get.width,
                      child:
                      Container(
                        padding: EdgeInsets.only(top:100),
                        margin: EdgeInsets.only(left: 16.0,right: 16.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.1,
                                blurRadius: 1,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            // border: Border.all(color: Colors.grey.shade300,width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                        ),
                        child:
                        details()
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:
                      Container(
                        width: Get.width,
                        // color: Colors.white,
                        // width: double.infinity,
                        height: Get.width/2,
                        margin: EdgeInsets.only(left: 32.0,right: 32.0,top: 16.0),
                        // margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:Colors.grey.withOpacity(0.9),
                                spreadRadius: 0.9,
                                blurRadius: 6,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            // border: Border.all(color: Colors.grey.shade300,width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(borderRadius+3))
                        ),
                        child:
                        ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child:
                            Image.network(controller.responseEntity.value.product.image??'',fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ):
      controller.getProductState.value == StateStatus.ERROR?
      Center(child:
      ConnectionError(parentAction: _onPressConnectionError,),):Container()),
    );
  }
  Widget details(){
    return  Container(
      margin: EdgeInsets.only(left: 0),
      child: Column(
        children: [
          Row(

            children: [
              Expanded(
                flex:6,
                child:
                Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(controller.responseEntity.value.product.title??'',style: TextStyle(fontWeight: FontWeight.bold),),
                        controller.responseEntity.value.product.description!= null?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.responseEntity.value.product.description),
                        ):Container(),
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.edit_outlined)),
                  onTap: (){
                    Get.toNamed(ZanaStorageRoutes.addProduct,arguments: controller.responseEntity.value).then((value) {
                      controller.getProduct(id);
                    });
                  },
                ),
              )
            ],
          ),
          controller.responseEntity.value.product.price!= null?myRow('Price', controller.responseEntity.value.product.price+' '+controller.responseEntity.value.product.currency.symbol):Container(),
          controller.responseEntity.value.product.quantity!= null?myRow('Quantity', controller.responseEntity.value.product.quantity.toString()):Container(),
          controller.responseEntity.value.product.discount!= null && controller.responseEntity.value.product.discount!=0?myRow('Discount', controller.responseEntity.value.product.quantity.toString()):Container(),
          controller.responseEntity.value.product.category!= null ?myRow('Category', controller.responseEntity.value.product.category.title):Container(),
          controller.responseEntity.value.product.tax.title!=null?myRow('Tax', controller.responseEntity.value.product.tax.title):Container(),
          controller.responseEntity.value.product.created_at!=null?myRow('Create', controller.responseEntity.value.product.created_at):Container(),
          controller.responseEntity.value.product.sku!=null?myRow('SKU', controller.responseEntity.value.product.sku):Container()

        ],
      ),
    );
  }
  Widget myRow(String title,String value){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
