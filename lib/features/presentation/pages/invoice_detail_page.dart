import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/data/model/init_model.dart';
import 'package:zana_storage/features/data/model/product_model.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/usecases/invoice/update_invoice_usecase.dart';
import 'package:zana_storage/features/presentation/controllers/init_controller.dart';
import 'package:zana_storage/features/presentation/controllers/invoice_controller.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'dart:math' as math;
import 'package:zana_storage/features/presentation/widgets/group_check_box.dart';
import 'package:zana_storage/helper/item.dart';
import 'package:zana_storage/utils/state_status.dart';
// ignore: must_be_immutable
class InvoiceDetailPage extends StatefulWidget {
  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  String invoiceId;

  double padding = 20;

  // UserController userController = Get.put(UserController());
  InvoiceController invoiceController = Get.put(InvoiceController());
  InitController initController = Get.put(InitController());
  List<Item> invoiceStatusList = new List();
  List<Item> statusList = new List();
  int _statusCheckedIndex=1;
  int _invoiceStatusCheckedIndex=1;
  var platform;
  ScrollController _scrollController = ScrollController();
  bool _visible = true;
  ReceivePort _port = ReceivePort();
  _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_visible == true) {
        setState(() {
          _visible = false;
        });
      }
    } else {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_visible == false) {
          setState(() {
            _visible = true;
          });
        }
      }
    }
  }

  _statusCheckedItem(int checkedIndex){
    _statusCheckedIndex = checkedIndex;
  }
  _invoiceStatusCheckedItem(int checkedIndex){
    _invoiceStatusCheckedIndex = checkedIndex;
  }
  GroupCheckBox statusGroupCheckBox;
  GroupCheckBox invoiceStatusGroupCheckBox;
  _getInvoiceStatus(InitEntity initEntity){
    if(initEntity != null)
      for(var item in initEntity.options[0].inv_statuses)
        invoiceStatusList.add(Item(title: item.title.tr,id: item.id.toString()));
    else
    {
      invoiceStatusList.add(Item(title: "Pending".tr,id: "1"));
      invoiceStatusList.add(Item(title: "Paid".tr,id: "2"));
      invoiceStatusList.add(Item(title: "Referred".tr,id: "3"));
      invoiceStatusList.add(Item(title: "Canceled".tr,id: "4"));
    }
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   initController.getInit(_getInvoiceStatus);
    statusList.add(Item(title: "Not Paid".tr,id: "0"));
    statusList.add(Item(title: "Paid".tr,id: "1"));
   invoiceId = Get.arguments.toString();
   invoiceController.getInvoice(invoiceId);
   _scrollController.addListener(_scrollListener);
   IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
   // _port.listen((dynamic data) {
   //   String id = data[0];
   //   DownloadTaskStatus status = data[1];
   //   int progress = data[2];
   //   setState((){ });
   // });
    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

  }
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if(status == DownloadTaskStatus.complete)
        Get.snackbar('Download Completed', 'The file is saved in the download folder',duration: Duration(seconds: 4));
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
  _refresh(bool refresh){
    setState(() {
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    invoiceController.invoice.value.id = null;
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // userController.getUserInfo();
    // List status = getStatus(invoice.status);
    return Scaffold(
      floatingActionButton:
      BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        scrollVisible: _visible,
        overlayColor: Colors.transparent,
        overlayOpacity: 0.3,
        children: [
          // MenuItem(
          //   // child: Icon(Icons.edit_outlined, color: Colors.white),
          //   title: "Status".tr,
          //   titleColor: Colors.white,
          //   subtitle: "You Can change the payment status".tr,
          //   subTitleColor: Colors.white,
          //   backgroundColor: Colors.deepOrange,
          //   onTap: () {
          //     Get.lazyPut<UpdateInvoiceUseCase>(() => UpdateInvoiceUseCase(
          //         repository: Get.find()
          //     ));
          //     statusGroupCheckBox =GroupCheckBox(
          //       title: "",
          //       items: statusList,
          //       checkedIndex: _statusCheckedIndex,
          //       parentAction: _statusCheckedItem,
          //     );
          //     Get.defaultDialog(
          //         confirm:
          //         Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: RaisedButton(
          //               color: Colors.blue,
          //               shape:RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(50.0),
          //                   // side: BorderSide(color: Colors.grey.shade300)
          //               ),
          //               child:
          //               Row(
          //                 children: [
          //                   Expanded(child:
          //
          //                   Padding(
          //                     padding: const EdgeInsets.all(16.0),
          //                     child: Text('ok'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          //                   )),
          //                 ],
          //               ),onPressed: (){
          //             Map<String, dynamic> jsonMap = {
          //               'status': invoiceController.invoice.value.status.toString(),
          //               'paid':_statusCheckedIndex,
          //               'payment_type':invoiceController.invoice.value.paymentType.toString()
          //             };
          //             String body = json.encode(jsonMap);
          //             invoiceController.updateInvoice(invoiceId, body);
          //             Get.back();
          //             // Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: id);
          //
          //           }),
          //         ),
          //         title: "select pay status".tr,
          //         content:
          //         Container(
          //           height: 150,
          //             child: statusGroupCheckBox)
          //         // Container(height :200,color: Colors.red,)
          //         // GroupCheckBox(title: "Select Payment Type",items: paymentTypeList,checkedIndex: 1,)
          //       // middleTextStyle: TextStyle(fontSize: 21,),
          //       // middleText: title
          //     );
          //   },
          // ),
          MenuItem(
            // child: Icon(Icons.brush, color: Colors.black),
            title: "Invoice Status".tr,
            titleColor: Colors.white,
            subtitle: "You Can change the invoice status".tr ,
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () {
              Get.lazyPut<UpdateInvoiceUseCase>(() => UpdateInvoiceUseCase(
                  repository: Get.find()
              ));
              invoiceStatusGroupCheckBox =GroupCheckBox(
                title: "",
                items: invoiceStatusList,
                checkedIndex: _invoiceStatusCheckedIndex,
                parentAction: _invoiceStatusCheckedItem,
              );
              Get.defaultDialog(
                  confirm:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        color: Colors.blue,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          // side: BorderSide(color: Colors.grey.shade300)
                        ),
                        child:
                        Row(
                          children: [
                            Expanded(child:

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('ok'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                            )),
                          ],
                        ),onPressed: (){
                          Map<String, dynamic> jsonMap = {
                            'status': _invoiceStatusCheckedIndex.toString(),
                            'paid':invoiceController.invoice.value.paid.toString(),
                            'payment_type':invoiceController.invoice.value.paymentType.toString()
                          };
                          String body = json.encode(jsonMap);
                          invoiceController.updateInvoice(invoiceId, body);
                      Get.back();
                      // Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: id);

                    }),
                  ),
                  title: "select invoice status".tr,
                  content:
                  Container(height:400,child: invoiceStatusGroupCheckBox)
                // middleTextStyle: TextStyle(fontSize: 21,),
                // middleText: title
              );
            },
          ),
          MenuItem(
            // child: Icon(Icons.edit_outlined, color: Colors.white),
            title: "Download".tr,
            titleColor: Colors.white,
            subtitle: "You Can download invoice as pdf to Download directory".tr,
            subTitleColor: Colors.white,
            backgroundColor: Colors.blueGrey.shade900,
            onTap: () async {
              // Get.snackbar('Download Completed', 'The file is saved in the download folder');
              Directory downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
              print(downloadsDirectory.path);
              if(await Permission.storage.request().isGranted)
                final taskId = await FlutterDownloader.enqueue(
                  requiresStorageNotLow: true,
                  url: '$baseUrl'+'invoice/pdf?id=$invoiceId',
                  savedDir: downloadsDirectory.path,
                  showNotification: true, // show download progress in status bar (for Android)
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                );
            }
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Detail'.tr),

      ),
      body:
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
            child: Obx(()=>
            invoiceController.invoice.value.id != null?
                Container(
                  padding: EdgeInsets.all(16),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: createInvoice(invoiceController.invoice.value.products)
                  ),
                ):
                invoiceController.getInvoiceState.value == StateStatus.LOADING?
            Center(child:  SpinKitDualRing(
              color: Colors.blue.shade200,
              size: 25.0,
            )):
                    invoiceController.getInvoiceState.value == StateStatus.ERROR?
            Center(child:
            ConnectionError(parentAction: _refresh,),):Container()
            ),
          ),

    );
  }

  List<Widget> createInvoice(List<ProductModel> products){

    List<Widget> list = new List();
    list.add(makeInvoiceHeader());
    list.add(
        SliverFixedExtentList(
        delegate: SliverChildListDelegate(
            [ Container(
              child:
              Column(
                children: [
                  Expanded(child: row2(false, 'Name'.tr, invoiceController.invoice.value.customer.family+" "+invoiceController.invoice.value.customer.name)),
                  Expanded(child: row2(true, 'Mobile'.tr, invoiceController.invoice.value.customer.mobile)),
                  Expanded(child: row2(false, 'Address'.tr, invoiceController.invoice.value.customer.address)),
                  Expanded(child: row2(true, 'Postal Code'.tr, invoiceController.invoice.value.customer.postalCode)),
                  Expanded(child: row2(false, 'Order Date'.tr, invoiceController.invoice.value.createdAt)),
                ],
              ),
            ),]
        ),
        itemExtent: 340
    ));
    int k=0;
    for(var product in products)
      {
        list.add(makeHeader(product.productName+" number ${++k}"),);
        list.add( SliverFixedExtentList(
            delegate: SliverChildListDelegate(
                [productCard(product),]
            ),
            itemExtent: 270));
      }
    return list;
  }
  Widget productCard(ProductModel product){
    return Column(
      children: [
        Expanded(child: row2(false, 'Price'.tr, product.price+" ${product.currencySymbol}")),
        Expanded(child: row2(true, 'Qty'.tr, product.quantity.toString())),
        Expanded(child: row2(false, 'Total'.tr, product.totalPrice+" ${product.currencySymbol}")),
        Expanded(child: row2(true, 'Discount'.tr, product.discount!=null?product.discount.toString():"0"+" %"))
      ],
    );
  }
  String paymentType(int paymentType){
    switch(paymentType){
      case 1:
        return "Credit Card".tr;
      case 2:
        return "Cash".tr;
      case 3:
        return "Check".tr;
      default:
        return "unknown";
    }
  }
  List getStatus(int status){
    switch (status){
      case 1:
        return [Colors.orangeAccent,'Pending'.tr];
      case 2:
        return [Colors.green,'Paid'.tr];
      case 3:
        return [Colors.grey,'Referred'.tr];
      case 4:
        return [Colors.red,'Cancelled'.tr];
      default:
        return [Colors.blue,'Bad Status'.tr];
    }
  }
  List getPaid(int paid){
    switch (paid){
      case 0:
        return [Colors.orangeAccent,'Not Paid'.tr];
      case 1:
        return [Colors.green,'Paid'.tr];
      default:
        return [Colors.blue,'Bad Status'.tr];
    }
  }
  Widget row2(bool isGray,String title,String value){
    return Container(
      padding: EdgeInsets.all(padding),
      color: isGray? Colors.grey.shade100:Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex:1,child: Text(title.tr)),
          
          Expanded(flex:2,child: AutoSizeText(value,textAlign: TextAlign.end,maxLines: 5,)),
        ],
      ),
    );
  }

  makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: false,
      // floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 120.0,
        child: Container(
          // margin: EdgeInsets.all(16),
            color: Colors.blueGrey.shade100, child: Center(child:
        Text(headerText))),
      ),
    );
  }
  makeInvoiceHeader() {
    _statusCheckedItem(invoiceController.invoice.value.paid);
    _invoiceStatusCheckedItem(invoiceController.invoice.value.status);
    return SliverPersistentHeader(
      pinned: true,
      // floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 90.0,
        maxHeight: 110.0,
        child:  Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              color: getStatus(invoiceController.invoice.value.status)[0],
              borderRadius: BorderRadius.only(topLeft:Radius.circular(borderRadius),topRight:Radius.circular(borderRadius))
          ),
          padding: EdgeInsets.all(padding),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getPaid(invoiceController.invoice.value.paid)[1],style: TextStyle(color: Colors.white),),
                  Text(invoiceController.invoice.value.invoiceId,style: TextStyle(color: Colors.white),),

                ],
              ),
              Column(
                children: [
                  Text(getStatus(invoiceController.invoice.value.status)[1],style: TextStyle(color: Colors.white),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}