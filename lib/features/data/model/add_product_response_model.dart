import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';

class AddProductResponseModel extends AddProductResponseEntity{


    AddProductResponseModel({
      Product product,
      int status,
    }):super(status: status,product: product);

    factory AddProductResponseModel.fromJson(Map<String, dynamic> json) {
        return AddProductResponseModel(
            product: json['product'] != null ? Product.fromJson(json['product']) : null, 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.product != null) {
            data['product'] = this.product.toJson();
        }
        return data;
    }
}

class Product {
    String barcode;
    String category_id;
    String created_at;
    String currency_id;
    String description;
    int discount;
    int id;
    String price;
    int quantity;
    int storeid;
    String tax_id;
    String title;
    String updated_at;
    int userid;

    Product({this.barcode, this.category_id, this.created_at, this.currency_id, this.description, this.discount, this.id, this.price, this.quantity, this.storeid, this.tax_id, this.title, this.updated_at, this.userid});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            barcode: json['barcode'], 
            category_id: json['category_id'], 
            created_at: json['created_at'], 
            currency_id: json['currency_id'], 
            description: json['description'], 
            discount: json['discount'], 
            id: json['id'], 
            price: json['price'], 
            quantity: json['quantity'], 
            storeid: json['storeid'], 
            tax_id: json['tax_id'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
            userid: json['userid'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['barcode'] = this.barcode;
        data['category_id'] = this.category_id;
        data['created_at'] = this.created_at;
        data['currency_id'] = this.currency_id;
        data['description'] = this.description;
        data['discount'] = this.discount;
        data['id'] = this.id;
        data['price'] = this.price;
        data['quantity'] = this.quantity;
        data['storeid'] = this.storeid;
        data['tax_id'] = this.tax_id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['userid'] = this.userid;
        return data;
    }
}