import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/presentation/controllers/customer_controller.dart';
import 'package:zana_storage/features/presentation/navigations/zana_storage.dart';
import 'package:zana_storage/features/presentation/pages/bindings/customer_binding.dart';
import 'package:zana_storage/features/presentation/pages/customer_detail_page.dart';
import 'package:zana_storage/features/presentation/widgets/connection_error.dart';
import 'package:zana_storage/utils/state_status.dart';

class Customers extends StatefulWidget {

  final ValueChanged<CustomerEntity> parentAction;
  bool isCustomerPage = false;
  Customers({this.parentAction,this.isCustomerPage});
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  CustomerEntity selectedCustomer;
  TextEditingController searchController = new TextEditingController();
  CustomerController customerController;
  int pageIndex = 1;
  String parameters,searchParams="";
  ScrollController _controller = ScrollController();
  _scrollListener() {
    print(_controller.offset);
    print(_controller.position.maxScrollExtent);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if(customerController.customerTableEntity.value.customers.length !=0)
        pageIndex = customerController.customerTableEntity.value.page+1;
      parameters = "page=$pageIndex&pagesize=$pageSize$searchParams";
      customerController.getCustomers(parameters);
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
  _onPressConnectionError(bool refresh){
    customerController.getCustomers(parameters);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    customerController.customers.clear();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_scrollListener);
    customerController = Get.put(CustomerController());
    parameters = "page=$pageIndex&pagesize=$pageSize";
    customerController.getCustomers(parameters);
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return
      Scaffold(

        floatingActionButton:widget.parentAction==null? FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Get.toNamed(ZanaStorageRoutes.addCustomerPage,arguments: true).then((value) {
              pageIndex = 1;
              customerController.customers.clear();
              parameters = "page=$pageIndex&pagesize=$pageSize";
              customerController.getCustomers(parameters);
            });
          },
        ):null,
          body:
          Obx(()=>
          Container(
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                    ),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      title: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: searchController,
                        textInputAction: TextInputAction.done,
                        decoration: new InputDecoration(

                            labelText: 'Search by name'.tr, border: InputBorder.none),
                        onEditingComplete: (){
                          pageIndex = 1;
                          searchParams = "&filterby=name&keywords=${searchController.text}";
                          parameters = "page=$pageIndex&pagesize=$pageSize$searchParams";
                          customerController.customers.clear();
                          customerController.getCustomers(parameters);
                          node.nextFocus();
                        },
                      ),
                      trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                        clearFilter();
                        node.nextFocus();
                      },),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child:
                    Container(
                      child:
                      Padding(
                        padding: EdgeInsets.only(left: 8,right: 8),
                        child:
                        customerController.customers.length!= 0 ?
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: _controller,
                                itemCount: customerController.customers.length,
                                itemBuilder: (context,index){
                                  return
                                    Container(
                                      margin: EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0,top: 8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                          InkWell(
                                            onTap: widget.isCustomerPage?(){
                                              Get.toNamed(ZanaStorageRoutes.customerDetailPage,arguments: customerController.customers[index]).then((value) {
                                                pageIndex = 1;
                                                customerController.customers.clear();
                                                parameters = "page=$pageIndex&pagesize=$pageSize";
                                                customerController.getCustomers(parameters);
                                              });
                                            }:(){
                                              widget.parentAction(customerController.customers[index]);
                                              Get.back();
                                            },
                                            child: Container(
                                              height: 80,
                                              child: 
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Expanded(child: Row(
                                                          children: [
                                                            Expanded(child: Text(customerController.customers[index].name+" "+ customerController.customers[index].family,style: TextStyle(fontWeight: FontWeight.bold),)),
                                                          ],
                                                        )),
                                                        Expanded(child: widget.isCustomerPage? Row(
                                                          children: [
                                                            Expanded(child: Text(customerController.customers[index].mobile,textAlign: TextAlign.start,)),
                                                          ],
                                                        ):Container()),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                      child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                            children: createDebit(index)),
                                                      ),
                                                      Column(
                                                        children: [
                                                          IconButton(icon: Icon(Icons.wysiwyg_outlined,size: 25,color: Colors.grey,), onPressed: (){
                                                            Get.toNamed(ZanaStorageRoutes.invoicesPage,arguments: customerController.customers[index].id);
                                                          }),
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                          )
                                        // ListTile(
                                        //   title: Text(customerController.customers[index].name+" "+
                                        //       customerController.customers[index].family,
                                        //   ),
                                        //   subtitle:
                                        //   Padding(
                                        //     padding: const EdgeInsets.only(top:16.0),
                                        //     child: widget.isCustomerPage? Text(customerController.customers[index].mobile,
                                        //     ):null,
                                        //   ),
                                        //   contentPadding: EdgeInsets.all(8),
                                        //   onTap: (){
                                        //     selectedCustomer = customerController.customers[index];
                                        //     if(widget.isCustomerPage){
                                        //       Get.to(CustomerDetailPage(customerEntity: selectedCustomer,),binding: CustomerBinding()).whenComplete((){
                                        //         clearFilter();
                                        //       });
                                        //     }
                                        //     else{
                                        //       if(widget.parentAction != null)
                                        //         widget.parentAction(selectedCustomer);
                                        //       Get.back();
                                        //     }
                                        //
                                        //   },
                                        // ),
                                      ),
                                    );
                                },

                              ),
                            ),
                            customerController.getCustomerState.value == StateStatus.LOADING?
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
                        customerController.getCustomerState.value == StateStatus.LOADING?
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            child: SpinKitDualRing(
                              color: Colors.blue.shade200,
                              size: 25,
                            ),
                          ),
                        )
                            :customerController.getCustomerState.value == StateStatus.ERROR?
                        ConnectionError(parentAction: _onPressConnectionError,):
                        Center(child: Text("Not Found".tr),),
                      )

                    )
                )
              ],
            ),
          )
          )
      );
  }
  List<Widget> createDebit(int index){
    List<Widget> row = new List();
    List<Widget> col = new List();
    // for(var item in customerController.customers[index].debit)
    //   row.add(Expanded(child: Text(item.price.toString()+" " +item.symbol)));
    int i = 0;
    for(var item in customerController.customers[index].debit)
     {
       i++;
       row.add(Expanded(
         child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Expanded(child: Text(item.price.toString()+" " +item.symbol,textAlign: TextAlign.end,)),
           ],
         ),
       ));
       if(i%2 == 0) {
         col.add(
             Expanded(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: row,),
         ));
        row = new List();
      }

    }
    if(customerController.customers[index].debit.length%2 !=0) {
      col.add(Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: row,
      )));
      col.add(Expanded(child: Container()));
    }
    return col;
  }
  clearFilter() {
    searchController.clear();
    pageIndex = 1;
    parameters = "page=$pageIndex&pagesize=$pageSize";
    customerController.customers.clear();
    customerController.getCustomers(parameters);

  }
}
