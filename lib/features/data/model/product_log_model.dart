import 'package:zana_storage/features/domain/entities/product_log_entity.dart';

class ProductLogModel extends ProductLogEntity{

    ProductLogModel({
      List<Log> logs,
      String page,
      String pageSize,
      Product product,
      int status,
      int total,}):super(
      logs: logs,
      pageSize: pageSize,
      page: page,
      product: product,
      status: status,
        total: total
    );

    factory ProductLogModel.fromJson(Map<String, dynamic> json) {
        return ProductLogModel(
            logs: json['logs'] != null ? (json['logs'] as List).map((i) => Log.fromJson(i)).toList() : null, 
            page: json['page'], 
            pageSize: json['pagesize'],
            product: json['product'] != null ? Product.fromJson(json['product']) : null, 
            status: json['status'], 
            total: json['total'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['page'] = this.page;
        data['pagesize'] = this.pageSize;
        data['status'] = this.status;
        data['total'] = this.total;
        if (this.logs != null) {
            data['logs'] = this.logs.map((v) => v.toJson()).toList();
        }
        if (this.product != null) {
            data['product'] = this.product.toJson();
        }
        return data;
    }
}

class Product {
    Object currency;
    int id;
    int quantity;
    Object tax;
    String title;

    Product({this.currency, this.id, this.quantity, this.tax, this.title});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            currency: json['currency'],
            id: json['id'], 
            quantity: json['quantity'], 
            tax: json['tax'],
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['quantity'] = this.quantity;
        data['title'] = this.title;
        data['currency'] = this.currency;
        data['tax'] = this.tax;
        return data;
    }
}

class Log {
    int change_qty;
    String created_at;
    String description;
    String id;
    int invoiceId;
    int productId;
    String status;
    int storeId;

    Log({this.change_qty, this.created_at, this.description, this.id, this.invoiceId, this.productId, this.status, this.storeId});

    factory Log.fromJson(Map<String, dynamic> json) {
        return Log(
            change_qty: json['change_qty'],
            created_at: json['created_at'],
            description: json['description'], 
            id: json['id'], 
            invoiceId: json['invoice_id'],
            productId: json['product_id'],
            status: json['status'], 
            storeId: json['store_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['change_qty'] = this.change_qty;
        data['created_at'] = this.created_at;
        data['description'] = this.description;
        data['id'] = this.id;
        data['product_id'] = this.productId;
        data['status'] = this.status;
        data['store_id'] = this.storeId;
        data['invoice_id'] = this.invoiceId;
        return data;
    }
}