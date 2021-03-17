import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';

class ManageProductModel extends ManageProductEntity{
    ManageProductModel({
        data,
        product,
        status
    }):super(
        data: data,
        product: product,
        status: status
    );

    factory ManageProductModel.fromJson(Map<String, dynamic> json) {
        return ManageProductModel(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            product: json['product'] != null ? Product.fromJson(json['product']) : null, 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.toJson();
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
    String updated_at;

    Product({this.currency, this.id, this.quantity, this.tax, this.updated_at});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            currency: json['currency'],
            id: json['id'], 
            quantity: json['quantity'], 
            tax: json['tax'] != json['tax'],
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['quantity'] = this.quantity;
        data['updated_at'] = this.updated_at;
        data['currency'] = this.currency;
        data['tax'] = this.tax;
        return data;
    }
}

class Data {
    String change_qty;
    String created_at;
    String description;
    String id;
    int product_id;
    String status;
    int store_id;

    Data({this.change_qty, this.created_at, this.description, this.id, this.product_id, this.status, this.store_id});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            change_qty: json['change_qty'], 
            created_at: json['created_at'], 
            description: json['description'], 
            id: json['id'], 
            product_id: json['product_id'], 
            status: json['status'], 
            store_id: json['store_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['change_qty'] = this.change_qty;
        data['created_at'] = this.created_at;
        data['description'] = this.description;
        data['id'] = this.id;
        data['product_id'] = this.product_id;
        data['status'] = this.status;
        data['store_id'] = this.store_id;
        return data;
    }
}