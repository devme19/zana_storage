import 'package:zana_storage/features/data/model/qr_product_model.dart';

class QrProductEntity{
  String barcode;
  int cat_id;
  String created_at;
  CurrencyModel currency;
  int currency_id;
  String deleted_at;
  String description;
  int discount;
  int id;
  String image;
  String price;
  int quantity;
  String sku;
  int storeid;
  TaxModel tax;
  int tax_id;
  String title;
  String unit;
  String updated_at;
  int userid;
  QrProductEntity({
    this.barcode,
    this.cat_id,
    this.created_at,
    this.currency,
    this.currency_id,
    this.deleted_at,
    this.description,
    this.discount,
    this.id,
    this.image,
    this.price,
    this.quantity,
    this.sku,
    this.storeid,
    this.tax,
    this.tax_id,
    this.title,
    this.unit,
    this.updated_at,
    this.userid,
});

}
class CurrencyEntity{
  String created_at;
  int id;
  String iso_code;
  String symbol;
  String title;
  String updated_at;
  CurrencyEntity({
    this.id,
    this.iso_code,
    this.symbol,
    this.title,
    this.updated_at,
    this.created_at
  });
}
class TaxEntity{
  int active;
  String created_at;
  int id;
  int storeid;
  int tax;
  String title;
  String updated_at;
  TaxEntity({
   this.active,
   this.created_at,
   this.id,
   this.storeid,
    this.tax,
    this.title,
    this.updated_at

  });
}