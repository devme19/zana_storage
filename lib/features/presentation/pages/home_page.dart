import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:zana_storage/features/presentation/controllers/dashboard_controller.dart';
import 'package:zana_storage/features/presentation/controllers/product_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/bindings/customer_binding.dart';
import 'package:zana_storage/features/presentation/utils/state_status.dart';
import 'package:zana_storage/features/presentation/widgets/alert_dialog.dart';
import 'package:zana_storage/helper/dashboard_items.dart';
import 'package:zana_storage/helper/menu.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'customers_page.dart';
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuItem> menuItems;
  List<Item> dashboardItems;
  // final autoSizeGroup = AutoSizeGroup();

  _selectedProduct(ProductEntity2 product){
    Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: product);
  }

  Widget goToManagePage(){
    Get.toNamed(ZanaStorageRoutes.manageProductPage,arguments: dashboardController.product.value);
    return Container();
  }

  DashboardController dashboardController;
  int _selectedIndex = -1;
  _onItemTapped(int index){
   setState(() {
     _selectedIndex = index;
   });
  }
  String dashboard(int index){
    switch(index){
      case 0:
        return (dashboardController.dashboardEntity.value.customers ??"").toString();
      case 1:
        return (dashboardController.dashboardEntity.value.invoices ??"").toString();
      case 2:
        return (dashboardController.dashboardEntity.value.customers_month ??"").toString();
      case 3:
        return (dashboardController.dashboardEntity.value.invoices_month ??"").toString();
      default:
        return "";
    }
  }

  @override
  void initState() {
    super.initState();
    dashboardController = Get.put(DashboardController());
    dashboardController.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    menuItems = new Menu().getMenu();
    dashboardItems = new DashboardItems().getItems();
    return
      Scaffold(
        extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: (){
            // Get.to(SettingPage());
            Get.toNamed(ZanaStorageRoutes.settingPage).then((value) {
              if(dashboardController.dashboardEntity.value.customers == null)
                dashboardController.getDashboard();
            });
          })
        ],
        title: Text("Zana Storage"),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(
        child: Obx(()=>dashboardController.getProductByQrState.value?
            CircularProgressIndicator(backgroundColor: Colors.white,):
            Icon(Icons.qr_code_scanner_outlined)),
        onPressed: () async {
          _onItemTapped(-1);
          if (await Permission.camera.request().isGranted) {
          String cameraScanResult = await scanner.scan();
          dashboardController.getProductByQr(cameraScanResult,_selectedProduct);
          // Obx(()=>dashboardController.product.value.id!=null?goToManagePage():error());

          // Either the permission was already granted before or the user just granted it.
          }
        },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
        BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            // color: Color(ox),
            // decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 0.1,
            //         blurRadius: 1,
            //         offset: Offset(0, 0), // changes position of shadow
            //       ),
            //     ],
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            // ),
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    _onItemTapped(0);
                    Get.toNamed(ZanaStorageRoutes.addCustomerPage);
                  },
                  child: Column(
                    children: [
                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset("asset/images/customer.svg", width:30,height: 30,color: _selectedIndex == 0?Colors.blue:Colors.grey.shade500),
                      ),),
                      Expanded(flex:1,child: Text("Add Customer".tr,style: TextStyle(color: _selectedIndex == 0? Colors.blue:Colors.grey.shade500),)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _onItemTapped(1);
                    Get.toNamed(ZanaStorageRoutes.addInvoicePage);
                  },
                  child: Column(
                    children: [

                      Expanded(flex:1,child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: SvgPicture.asset("asset/images/invoice.svg",width:30,height: 30,color: _selectedIndex == 1?Colors.blue:Colors.grey.shade500),
                      ),),
                      Expanded(flex:1,child: Text("Add Invoice".tr,style: TextStyle(color: _selectedIndex == 1? Colors.blue:Colors.grey.shade500),)),
                    ],
                  ),
                ),
              ],
            ),
            // child: BottomNavigationBar(
            //
            //   items: [
            //     BottomNavigationBarItem(icon: Image.asset("asset/images/1.png",width: 30,height: 30,),label: "Add Customer",),
            //     BottomNavigationBarItem(icon:  Image.asset("asset/images/2.png",width: 30,height: 30,),label: "Add Invoice"),
            //   ],
            // ),
          ),
          //other params
        //other params
      ),
      body:
      Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          color: Colors.white,
          // margin: EdgeInsets.only(bottom: 60),
          // color: Color.fromRGBO(240, 244, 253, 1),
          child:
          Container(
            child:
              ListView(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: menuWidget(),
                    ),
                  ),
                  Divider(thickness: 5,color: Get.theme.scaffoldBackgroundColor,),
                  Container(
                    height: 500,
                      margin: EdgeInsets.only(left:16.0,right: 16.0,top: 16.0),
                      child: dashboardWidget()),
                ],
              )
            // CustomScrollView(
            //   slivers: <Widget>[
            //     SliverToBoxAdapter(
            //       child: Container(
            //         child: Padding(
            //           padding: const EdgeInsets.only(left:16.0,top: 25,right: 32),
            //           child: Text("Menu".tr,),
            //         ),
            //       ),
            //     ),
            //     SliverPadding(
            //       padding: EdgeInsets.all(16),
            //       sliver: SliverGrid(
            //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 200,
            //           mainAxisSpacing: 15.0,
            //           crossAxisSpacing: 15.0,
            //           childAspectRatio: 1.0,
            //         ),
            //         delegate: SliverChildBuilderDelegate(
            //               (BuildContext context, int index) {
            //             return
            //               getMenu(index);
            //           },
            //           childCount: 3,
            //         ),
            //       ),
            //     ),
            //     SliverToBoxAdapter(
            //       child: Container(
            //         child: Padding(
            //           padding: const EdgeInsets.only(left:16.0,top: 25,right: 16),
            //           child: Text("Summary".tr,),
            //         ),
            //       ),
            //     ),
            //     SliverPadding(
            //       padding: EdgeInsets.all(16),
            //       sliver: SliverGrid(
            //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 250,
            //           mainAxisSpacing: 15.0,
            //           crossAxisSpacing: 15.0,
            //           childAspectRatio: 1.0,
            //         ),
            //         delegate: SliverChildBuilderDelegate(
            //               (BuildContext context, int index) {
            //             return
            //               myDashboardItem(index);
            //           },
            //           childCount: 4,
            //         ),
            //       ),
            //     ),
            //
            //     // SliverToBoxAdapter(
            //     //   child:
            //     //       Container(
            //     //         height: 500,
            //     //        color: Colors.red.shade300,
            //     //       child: GridView.count(
            //     //         padding: EdgeInsets.all(30),
            //     //         crossAxisCount: 2 ,
            //     //         crossAxisSpacing: 30,
            //     //         mainAxisSpacing: 30,
            //     //         children: List.generate(dashboardItems.length,(index){
            //     //           return
            //     //             myDashboardItem(index);
            //     //         }),
            //     //       ),
            //     //       )
            //     // ),
            //     // SliverToBoxAdapter(
            //     //   child: Padding(
            //     //     padding: const EdgeInsets.only(left:32.0,right: 32.0),
            //     //     child: Text("Menu".tr,style: TextStyle(fontSize: 20),),
            //     //   ),
            //     // ),
            //     // SliverPadding(padding: EdgeInsets.all(0),
            //     //   sliver: SliverGrid(
            //     //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     //       crossAxisCount: 3,
            //     //       mainAxisSpacing: 10.0,
            //     //       crossAxisSpacing: 10.0,
            //     //       childAspectRatio: 1.0,
            //     //     ),
            //     //     delegate: SliverChildBuilderDelegate(
            //     //           (BuildContext context, int index) {
            //     //         return
            //     //           getMenu(index);
            //     //       },
            //     //       childCount: 3,
            //     //     ),
            //     //   ),
            //     // )
            //
            //
            //
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  Widget error(){
    MyAlertDialog.show(['Connection failed'.tr],true);
    return Container();
  }
  Widget menuWidget(){
    return
      Container(
        height: 250,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
        ),
        child: Column(
          children: [
            Row(children: [
              Container(
                height: 60,
                padding: EdgeInsets.only(left:16.0,right:16.0),
                child: Center(child: Text("Menu".tr,style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
            ],),
            // Padding(
            //   padding: const EdgeInsets.only(left:16.0,right: 16),
            //   child: Divider(),
            // ),
            Expanded(
              flex: 3,
              child:
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0,left: 8.0,right: 8.0,top: 16.0),
                child: Row(
                  children: [
                    Expanded(child: getMenu(0)),
                    Expanded(child: getMenu(1)),
                    Expanded(child: getMenu(2)),
                  ],)
              ),
            ),
          ],
        ),
      );
  }
  Widget dashboardWidget(){
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      child:Column(children: [
        Row(children: [
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 16.0,right: 16.0),
            child: Center(child: Text("Summary".tr,style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
        ],),
        // Padding(
        //   padding: const EdgeInsets.only(left:16.0,right: 16.0),
        //   child: Divider(),
        // ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: myDashboardItem(0)),
              Expanded(child: myDashboardItem(1)),
            ],),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: myDashboardItem(2)),
              Expanded(child: myDashboardItem(3)),
            ],),
          ),
        )
      ],),
    );
  }
 Widget myDashboardItem(int index){
    return
      Container(
        margin: EdgeInsets.only(left:8.0,right: 8.0),
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
          child: Container(
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle
                          ),
                          child: dashboardItems[index].icon
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     Obx(()=> AutoSizeText(
                         dashboard(index)
                         ,
                         maxLines: 1,
                         style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800)
                     ),)
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                          dashboardItems[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade500,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      );
 }
  Widget getMenu(int index){
    return InkWell(
      child:
      Container(
        margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.7,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(margin:EdgeInsets.only(top: 10.0),child: menuItems[index].image)
                ),
                Expanded(child: Container()),
                Expanded(
                  child: AutoSizeText(
                      menuItems[index].title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500,)
                  ),
                ),
              ],
            ),
          )
      ),
      // Container(
      //   padding: EdgeInsets.only(top: 32,bottom: 32),
      //   decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.1),
      //           spreadRadius: 0.9,
      //           blurRadius: 10,
      //           offset: Offset(0, 3), // changes position of shadow
      //         ),
      //       ],
      //       color: Colors.white,
      //       borderRadius: BorderRadius.all(Radius.circular(15))
      //   ),
      //   child: Column(
      //     children: [
      //       Expanded(flex:2,child: menuItems[index].image),
      //       // SizedBox(height: 50,),
      //       Expanded(child: Container(),flex: 1,),
      //       Expanded(flex:2,child: Text(
      //           menuItems[index].title,
      //           style: TextStyle(color: Colors.grey.shade600)
      //       )),
      //     ],
      //   ),
      // ),
      onTap: (){
        switch(index){
          case 0:
          // Get.to(ZanaStorageRoutes.customerPage);
          Get.to(CustomerPage(isCustomerPage: true,),binding: CustomerBinding()).then((value) {
            if(dashboardController.dashboardEntity.value.customers == null)
              dashboardController.getDashboard();
          });
            // Get.toNamed(ZanaStorageRoutes.customerPage,arguments: );
            break;
          case 1:
            Get.toNamed(ZanaStorageRoutes.invoicesPage).then((value) {
              if(dashboardController.dashboardEntity.value.customers == null)
                dashboardController.getDashboard();
            });
            break;
          case 2:
            Get.toNamed(ZanaStorageRoutes.productsPage).then((value) {
              if(dashboardController.dashboardEntity.value.customers == null)
                dashboardController.getDashboard();
            });
            break;
        }

        print(menuItems[index].title);
      },
    );
  }

}


