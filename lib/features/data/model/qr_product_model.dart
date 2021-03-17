import 'package:zana_storage/features/domain/entities/qr_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class QrProductModel extends QrProductEntity{

    QrProductModel({
        CurrencyModel currency,
        String barcode,
        int cat_id,
        String created_at,
        int currency_id,
        String deleted_at,
        String description,
        int discount,
        int id,
        String image,
        String price,
        int quantity,
        String sku,
        int storeid,
        TaxModel tax,
        int tax_id,
        String title,
        String unit,
        String updated_at,
        int userid}):
        super(
            currency: currency,
            barcode:barcode,
            cat_id:cat_id,
            created_at:created_at,
            currency_id:currency_id,
            deleted_at:deleted_at,
            description:description,
            discount:discount,
            id:id,
            image:image,
            price:price,
            quantity:quantity,
            sku:sku,
            storeid:storeid,
            tax_id:tax_id,
            title:title,
            unit:unit,
            updated_at:updated_at,
            userid:userid
            );

    factory QrProductModel.fromJson(Map<String, dynamic> json) {
        json = json["product"];
        return QrProductModel(
            barcode: json['barcode'], 
            cat_id: json['cat_id'], 
            created_at: json['created_at'], 
            currency: json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null,
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
            tax: json['tax'] != null ? TaxModel.fromJson(json['tax']) : null,
            tax_id: json['tax_id'], 
            title: json['title'], 
            unit: json['unit'],
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
        data['deleted_at'] = this.deleted_at;
        data['unit'] = this.unit;
        if (this.currency != null) {
            data['currency'] = this.currency.toJson();
        }
        if (this.tax != null) {
            data['tax'] = this.tax.toJson();
        }
        return data;
    }
}

class TaxModel extends TaxEntity {
    TaxModel({
        int active,
        String created_at,
        int id,
        int storeid,
        int tax,
        String title,
        String updated_at,
    }):super(
        active: active,
        created_at: created_at,
        id: id,
        storeid: storeid,
        tax: tax,
        updated_at: updated_at,
        title: title
    );
       factory TaxModel.fromJson(Map<String, dynamic> json) {
        return TaxModel(
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

class CurrencyModel extends CurrencyEntity{
    CurrencyModel({
        String created_at,
        int id,
        String iso_code,
        String symbol,
        String title,
        String updated_at,
    }):super(
        created_at: created_at,
        id: id,
        iso_code: iso_code,
        symbol: symbol,
        title: title,
        updated_at: updated_at
    );
    factory CurrencyModel.fromJson(Map<String, dynamic> json) {
        return CurrencyModel(
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