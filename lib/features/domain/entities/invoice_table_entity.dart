import 'package:zana_storage/features/data/model/invoice_model.dart';

class InvoiceTableEntity{

  String page;
  String pageSize;
  String sortBy;
  int status;
  int total;
  List<InvoiceModel> invoices;

  InvoiceTableEntity({
    this.invoices,
    this.page,
    this.pageSize,
    this.sortBy,
    this.status,
    this.total
  });
}