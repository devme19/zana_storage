import 'package:zana_storage/features/domain/entities/product_entity3.dart';

class ProductModel3 extends ProductEntity3{


    ProductModel3({
      Product product,
      int status}):super(
      product: product,
      status: status
    );

    factory ProductModel3.fromJson(Map<String, dynamic> json) {
        return ProductModel3(
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
    int cat_id;
    String created_at;
    Currency currency;
    Category category;
    int currency_id;
    Object deleted_at;
    String description;
    int discount;
    int id;
    String image;
    String price;
    int quantity;
    String sku;
    int storeid;
    Tax tax;
    int tax_id;
    String title;
    Object unit;
    String updated_at;
    int userid;

    Product({this.barcode,this.category, this.cat_id, this.created_at, this.currency, this.currency_id, this.deleted_at, this.description, this.discount, this.id, this.image, this.price, this.quantity, this.sku, this.storeid, this.tax, this.tax_id, this.title, this.unit, this.updated_at, this.userid});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            barcode: json['barcode'], 
            cat_id: json['category_id'],
            created_at: json['created_at'], 
            currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null, 
            category: json['category'] != null ? Category.fromJson(json['category']) : null,
            currency_id: json['currency_id'],
            deleted_at: json['deleted_at'] ,
            description: json['description'], 
            discount: json['discount'], 
            id: json['id'], 
            image: json['image'], 
            price: json['price'], 
            quantity: json['quantity'], 
            sku: json['sku'], 
            storeid: json['storeid'], 
            tax: json['tax'] != null ? Tax.fromJson(json['tax']) : null, 
            tax_id: json['tax_id'], 
            title: json['title'], 
            unit: json['unit'] ,
            updated_at: json['updated_at'], 
            userid: json['userid'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['barcode'] = this.barcode;
        data['cat_id'] = this.cat_id;
        data['created_at'] = this.created_at;
        data['currency_id'] = this.currency_id;
        data['description'] = this.description;
        data['discount'] = this.discount;
        data['id'] = this.id;
        data['image'] = this.image;
        data['price'] = this.price;
        data['quantity'] = this.quantity;
        data['sku'] = this.sku;
        data['storeid'] = this.storeid;
        data['tax_id'] = this.tax_id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['userid'] = this.userid;
        if (this.currency != null) {
            data['currency'] = this.currency.toJson();
        }
        if (this.category != null) {
            data['category'] = this.category.toJson();
        }
        data['deleted_at'] = this.deleted_at;
        if (this.tax != null) {
            data['tax'] = this.tax.toJson();
        }
        data['unit'] = this.unit;
        return data;
    }
}

class Tax {
    int active;
    String created_at;
    int id;
    int storeid;
    int tax;
    String title;
    String updated_at;

    Tax({this.active, this.created_at, this.id, this.storeid, this.tax, this.title, this.updated_at});

    factory Tax.fromJson(Map<String, dynamic> json) {
        return Tax(
            active: json['active'], 
            created_at: json['created_at'], 
            id: json['id'], 
            storeid: json['storeid'], 
            tax: json['tax'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['storeid'] = this.storeid;
        data['tax'] = this.tax;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class Currency {
    String created_at;
    int id;
    String iso_code;
    String symbol;
    String title;
    String updated_at;

    Currency({this.created_at, this.id, this.iso_code, this.symbol, this.title, this.updated_at});

    factory Currency.fromJson(Map<String, dynamic> json) {
        return Currency(
            created_at: json['created_at'], 
            id: json['id'], 
            iso_code: json['iso_code'], 
            symbol: json['symbol'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['iso_code'] = this.iso_code;
        data['symbol'] = this.symbol;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class Category {
    int add_by;
    String created_at;
    int id;
    int storeid;
    String title;
    String updated_at;

    Category({this.add_by, this.created_at, this.storeid, this.id,this.title, this.updated_at});

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            add_by: json['add_by'], 
            created_at: json['created_at'],
            id: json['id'],
            storeid: json['storeid'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['add_by'] = this.add_by;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['storeid'] = this.storeid;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}