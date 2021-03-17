import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/presentation/widgets/customers.dart';

class CustomerPage extends StatefulWidget {

  final ValueChanged<CustomerEntity> parentAction;
  bool isCustomerPage;
 CustomerPage({this.parentAction,this.isCustomerPage});
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customers'.tr),
        ),
        body: Customers(parentAction: widget.parentAction,isCustomerPage: widget.isCustomerPage));
  }

  @override
  void initState() {
    super.initState();

  }
}
