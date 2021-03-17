import 'package:zana_storage/features/data/model/customer_model.dart';
import 'package:zana_storage/features/data/model/invoice_model.dart';
import 'package:zana_storage/features/data/model/product_model.dart';

class InvoiceEntity{
  int addBy;
  String cost;
  String createdAt;
  CustomerModel customer;
  String customerType;
  int customerId;
  String description;
  String discount;
  int id;
  String invoiceId;
  int paid;
  Object paidAt;
  int paymentType;
  List<ProductModel> products;
  String realTotal;
  RealTotalp realTotalp;
  int status;
  int storeId;
  String updatedAt;
  InvoiceEntity({
    this.addBy,
    this.cost,
    this.createdAt,
    this.customer,
    this.customerType,
    this.customerId,
    this.description,
    this.discount,
    this.id,
    this.invoiceId,
    this.paid,
    this.paidAt,
    this.paymentType,
    this.products,
    this.realTotal,
    this.realTotalp,
    this.status,
    this.storeId,
    this.updatedAt,
});
}