import 'package:zana_storage/features/data/model/product_log_model.dart';

class ProductLogEntity{
  List<Log> logs;
  String page;
  String pageSize;
  Product product;
  int status;
  int total;

  ProductLogEntity({
  this.logs,
    this.pageSize,
    this.page,
    this.product,
    this.status,
    this.total
  });
}