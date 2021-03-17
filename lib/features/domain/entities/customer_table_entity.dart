import 'package:zana_storage/features/data/model/customer_model.dart';

class CustomerTableEntity{

  int page;
  int pageSize;
  String sortBy;
  int status;
  int total;
  List<CustomerModel> customers;

  CustomerTableEntity({
    this.page,
    this.pageSize,
    this.sortBy,
    this.status,
    this.total,
    this.customers
  });
}