import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/presentation/controllers/invoice_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/utils/state_status.dart';

class InvoicesPage extends StatefulWidget {
  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {

  InvoiceController invoiceController = Get.put(InvoiceController());
  int pageIndex = 1;
  ScrollController _controller = ScrollController();
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if(invoiceController.invoiceTable.value.invoices.length!=0)
        pageIndex = int.parse(invoiceController.invoiceTable.value.page)+1;
      invoiceController.getInvoices(pageIndex,pageSize);
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
     invoiceController.getInvoices(pageIndex,pageSize);
  }
  _onPressConnectionError(bool refresh){
    pageIndex = 1;
    invoiceController.getInvoices(pageIndex,pageSize);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){
          invoiceController.invoices.clear();
          Get.toNamed(ZanaStorageRoutes.addInvoicePage).then((value) {
            pageIndex = 1;
            // // invoiceController.invoices.clear();
            invoiceController.getInvoices(pageIndex,pageSize);
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Invoices'.tr),
      ),
      body:
      Container(
        color: Colors.grey.shade200,
        child: Obx(()=>
            invoiceController.invoices.length!=0?
            Container(
              // margin: EdgeInsets.only(top: 8),
              child:createListCard()
            ):
                invoiceController.getInvoicesState.value == StateStatus.LOADING?
            Center(child: SpinKitDualRing(
              color: Colors.blue.shade200,
              size: 25.0,
            )):
            invoiceController.getInvoicesState.value == StateStatus.ERROR?
                ConnectionError(parentAction: _onPressConnectionError,)
                :Container()
        ),
      ),

    );
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

  Widget createListCard(){
    return RefreshIndicator(
        child:
        Column(
          children: [
            Expanded(
              child: ListView.builder(
              controller: _controller,
              itemBuilder: (context,index){
                List status = getStatus(invoiceController.invoices[index].status);
                return
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0.8,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                    ),
                    margin: EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: invoiceController.invoices[index].id).then((value) {
                          pageIndex = 1;
                          // // invoiceController.invoices.clear();
                          invoiceController.getInvoices(pageIndex,pageSize);
                        });
                        invoiceController.invoices.clear();
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: status[0],
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(borderRadius),topRight:Radius.circular(borderRadius))
                            ),
                            padding: EdgeInsets.only(left:20,right: 20.0,top: 30,bottom: 30),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(invoiceController.invoices[index].invoiceId,style: TextStyle(color: Colors.white),),
                                Text(status[1],style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('Invoice No.'.tr),
                          //
                          //
                          //     ],
                          //   ),
                          // ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Customer'.tr),
                                invoiceController.invoices[index].customer!=null?
                                Text(invoiceController.invoices[index].customer.name+" "+invoiceController.invoices[index].customer.family):
                                Container(),

                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mobile'.tr),
                                invoiceController.invoices[index].customer!=null?
                                Text(invoiceController.invoices[index].customer.mobile??""):
                                Container()

                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Price'.tr),
                                Text(invoiceController.invoices[index].realTotal.toString()??""),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  );
              },
              // separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: invoiceController.invoices.length
    ),
            ),
            invoiceController.getInvoicesState.value == StateStatus.LOADING?
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
        ),
        onRefresh: (){
          return refresh();
        });

  }
  Future<void> refresh() async{
    pageIndex = 1;
    invoiceController.invoices.clear();
    return invoiceController.getInvoices(pageIndex,pageSize);
  }
}
