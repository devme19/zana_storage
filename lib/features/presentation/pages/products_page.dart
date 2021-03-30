import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:zana_storage/features/presentation/controllers/product_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/utils/state_status.dart';
class ProductsPage extends StatefulWidget {
  final ValueChanged<ProductEntity2> parentAction;
  ProductsPage({this.parentAction});
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>{

  ProductController productController;
  int pageIndex = 1;
  ScrollController _controller = ScrollController();
  TextEditingController searchController = TextEditingController();
  String parameters,searchParam="";
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if(productController.productTable.value.products.length!=0)
        pageIndex = productController.productTable.value.page+1;
      parameters = "page=$pageIndex&pagesize=$pageSize"+searchParam;
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
  _onSearchTxtChange(){
    if(searchController.text.length>0) {

    }
  }
  _onPressConnectionError(bool refresh){
    productController.getProducts(parameters);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    productController.products.clear();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    productController = Get.put(ProductController());
    _controller.addListener(_scrollListener);
    searchController.addListener(_onSearchTxtChange);
    parameters = "page=$pageIndex&pagesize=$pageSize";
    productController.getProducts(parameters);
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.toNamed(ZanaStorageRoutes.addProduct);
        },
      ),
      appBar: AppBar(
        title: Text('Products'.tr),
      ),
      body:
      Obx(()=>

      RefreshIndicator(
        onRefresh: ()=>refresh(),
        child:
        Container(
          color: Colors.grey.shade200,
          child:
          Column(
            children: [
              Container(
                // color: Colors.white,
                // height: 75,
                // padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
                margin: EdgeInsets.all(16),
                child:
                ListTile(
                  title: TextFormField(
                    controller: searchController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: (){
                      searchParam = "&filterby=title&keywords=${searchController.text}";
                      productController.products.clear();
                      productController.getProducts(searchParam);
                      node.nextFocus();
                    },
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.description),
                      border: InputBorder.none,
                      labelText: 'Search by title'.tr,
                      // suffix: IconButton(
                      //   icon: Icon(Icons.clear),
                      //   onPressed: (){
                      //     searchController.clear();
                      //     parameters = "page=$pageIndex&pagesize=$pageSize";
                      //     productController.getProducts(parameters);
                      //   },
                      // )
                      // border: null,
                    ),
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    pageIndex = 1;
                    parameters = "page=$pageIndex&pagesize=$pageSize";
                    productController.products.clear();
                    productController.getProducts(parameters);
                    searchController.clear();
                    node.nextFocus();
                  },),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  // padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(left: 13,right: 13),
                  child:productController.products.length!=0?
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _controller,
                          itemCount: productController.products.length,itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                productController.products[index].isExpanded=!productController.products[index].isExpanded;
                              });
                            },
                            child: (
                                Card(
                                  child:
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex:2,
                                            child: Container(
                                              height:150,
                                              margin: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child:productController.products[index].image !=null? Image.network(productController.products[index].image,fit: BoxFit.cover,):Container(
                                                    child: Icon(Icons.image_search,size: 30,),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex:3,
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(productController.products[index].title)),
                                                Expanded(
                                                  child: ExpandIcon(
                                                    isExpanded: productController.products[index].isExpanded,
                                                    color: Colors.grey,
                                                    expandedColor: Colors.grey,
                                                    onPressed: (bool isExpanded) {
                                                      setState(() {
                                                        productController.products[index].isExpanded = !isExpanded;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      productController.products[index].isExpanded?
                                      Column(
                                        children: [
                                          row2(true, 'Sku'.tr, productController.products[index].sku==null?"":productController.products[index].sku),
                                          row2(false, 'Price'.tr, productController.products[index].price+" "+productController.products[index].symbol),
                                          row2(true, 'Quantity'.tr, productController.products[index].quantity.toString()),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                RaisedButton(
                                                    color: Colors.green,
                                                    shape:RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(borderRadius),
                                                      // side: BorderSide(color: Colors.yellowAccent)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child:
                                                      AutoSizeText('Manage'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
                                                    ),onPressed: ()=>Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: productController.products[index])),
                                                RaisedButton(
                                                    color: Colors.green,
                                                    shape:RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(borderRadius),
                                                      // side: BorderSide(color: Colors.yellowAccent)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child:
                                                      AutoSizeText('Detail'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
                                                    ),onPressed: (){
                                                  Get.toNamed(ZanaStorageRoutes.detailProductPage,arguments: productController.products[index].id).then((value) {
                                                    refresh();
                                                  });
                                                }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ):Container()
                                    ],
                                  ),
                                )),
                          );
                        },),
                      ),
                      // createListCard( productController.products),
                      productController.getProductsState.value == StateStatus.LOADING?
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: SpinKitDualRing(
                            color: Colors.blue.shade200,
                            size: 25,
                          ),
                        ),
                      ):Container()
                    ],
                  ):
                  productController.getProductsState.value == StateStatus.LOADING?
                  Center(child: SpinKitDualRing(
                    color: Colors.blue.shade200,
                    size: 25.0,
                  )):productController.getProductsState.value == StateStatus.ERROR?
                  Center(child:
                  ConnectionError(parentAction: _onPressConnectionError,),):
                  Center(child: Text("Not Found".tr),),
                ),
              )
            ],
          ),
        ),
      )
      ),

    );
  }
  Widget createListCard(RxList products){
    // List<Widget> list = new List();
    //
    // for(var item in products)
    //   list.add(InkWell(
    //     onTap: (){
    //       setState(() {
    //         item.isExpanded = !item.isExpanded;
    //       });
    //     },
    //     child: (
    //         Card(
    //       child:
    //       Column(
    //         children: [
    //           Row(
    //             children: [
    //               Container(
    //                 height:150,
    //                 child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(0),
    //                     child:item.image !=null? Image.network(item.image,fit: BoxFit.cover,):Container(
    //                       child: Icon(Icons.image_search,size: 30,),
    //                     )),
    //               ),
    //               Text(item.title),
    //               ExpandIcon(
    //                 isExpanded: item.isExpanded,
    //                 color: Colors.grey,
    //                 expandedColor: Colors.grey,
    //                 onPressed: (bool isExpanded) {
    //                   setState(() {
    //                     item.isExpanded = !isExpanded;
    //                   });
    //                 },
    //               ),
    //             ],
    //           ),
    //           item.isExpanded?
    //           Column(
    //             children: [
    //           row2(true, 'Sku'.tr, item.sku==null?"":item.sku),
    //           row2(false, 'Price'.tr, item.price+" "+item.symbol),
    //           row2(true, 'Quantity'.tr, item.quantity.toString()),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 RaisedButton(
    //                     color: Colors.green,
    //                     shape:RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(borderRadius),
    //                       // side: BorderSide(color: Colors.yellowAccent)
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(16.0),
    //                       child:
    //                       AutoSizeText('Manage'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
    //                     ),onPressed: ()=>Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: item)),
    //                 RaisedButton(
    //                     color: Colors.green,
    //                     shape:RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(borderRadius),
    //                       // side: BorderSide(color: Colors.yellowAccent)
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(16.0),
    //                       child:
    //                       AutoSizeText('Detail'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
    //                     ),onPressed: (){
    //                   Get.toNamed(ZanaStorageRoutes.detailProductPage,arguments: item.id).then((value) {
    //                     refresh();
    //                   });
    //                 }
    //                 ),
    //               ],
    //             ),
    //           ),
    //             ],
    //           ):Container()
    //         ],
    //       ),
    //     )),
    //   ));
    return
      ExpansionPanelList(
        elevation:1,
        animationDuration: Duration(milliseconds: 500),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            products[index].isExpanded = !isExpanded;
          });
        },
        children:
        products.map<ExpansionPanel>((var item) {
          return
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return
                  // ListTile(
                  //   title:  Text(item.title),
                  //   trailing:  Image.network("https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI",fit: BoxFit.cover,),
                  GestureDetector(
                    child: Container(

                      padding: EdgeInsets.all(8),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:
                            AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                height:120,
                                width: 120,
                                child:
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child:item.image !=null? Image.network(item.image,fit: BoxFit.cover,):Container(
                                      child: Icon(Icons.image_search,size: 30,),
                                    ))),
                          ),
                          Expanded(
                              flex: 2,
                              child: Center(child: Text(item.title))
                          ),

                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        item.isExpanded = !isExpanded;
                      });
                    },
                  );
              },
              body:
              GestureDetector(
                onTap: (){
                  Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: item);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      row2(true, 'Sku'.tr, item.sku==null?"":item.sku),
                      row2(false, 'Price'.tr, item.price+" "+item.symbol),
                      row2(true, 'Quantity'.tr, item.quantity.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          RaisedButton(
                              color: Colors.green,
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                // side: BorderSide(color: Colors.yellowAccent)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                AutoSizeText('Manage'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
                              ),onPressed: ()=>Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: item)),
                          RaisedButton(
                              color: Colors.green,
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                // side: BorderSide(color: Colors.yellowAccent)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                AutoSizeText('Detail'.tr,maxLines: 1,style: TextStyle(color: Colors.white),),
                              ),onPressed: (){
                            Get.toNamed(ZanaStorageRoutes.detailProductPage,arguments: item.id).then((value) {
                              refresh();
                            });
                          }
                              ),
                        ],),
                      )
                    ],
                  ),
                ),
              ),
              isExpanded: item.isExpanded,
            );
        }).toList(),
      );

  }
  Future<void> refresh() async{
    pageIndex = 1;
    productController.products.clear();
    parameters = "page=$pageIndex&pagesize=$pageSize";
    // invoiceController.invoiceTable = new InvoiceTableEntity().obs;

    return productController.getProducts(parameters);
  }
  Widget row2(bool isGray,String title,String value){
    return Container(
      padding: EdgeInsets.all(20),
      color: isGray? Colors.grey.shade100:Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr),
          Text(value),
        ],
      ),
    );
  }
}
class Expansion extends StatefulWidget {
  var products;
  Expansion({this.products});
  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  @override
  Widget build(BuildContext context) {
    return
      ExpansionPanelList(
      elevation:1,
      animationDuration: Duration(milliseconds: 500),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.products[index].isExpanded = !isExpanded;
        });
      },
      children:
      widget.products.map<ExpansionPanel>((var item) {
        return
          ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return
                // ListTile(
                //   title:  Text(item.title),
                //   trailing:  Image.network("https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI",fit: BoxFit.cover,),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                          AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              height:120,
                              width: 120,
                              child:
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network("https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI",fit: BoxFit.cover,))),
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(child: Text(item.title))
                        ),

                      ],
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      item.isExpanded = !isExpanded;
                    });
                  },
                );
            },
            body: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  row2(true, 'Sku'.tr, item.sku),
                  row2(false, 'Price'.tr, item.price),
                  row2(true, 'Quantity'.tr, item.quantity.toString()),
                  Row(children: [
                    IconButton(icon: Icon(Icons.wrap_text,color: Colors.blueGrey,), onPressed: (){
                      Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: item.id.toString());
                    })
                  ],)
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
      }).toList(),
    );
  }
  Widget row2(bool isGray,String title,String value){
    return Container(
      padding: EdgeInsets.all(20),
      color: isGray? Colors.grey.shade100:Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr),
          Text(value),
        ],
      ),
    );
  }
}

