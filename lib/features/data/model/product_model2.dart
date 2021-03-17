import 'package:zana_storage/features/domain/entities/product_entity2.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ProductModel2 extends ProductEntity2{

    ProductModel2({
      String category,
      int id,
      String image,
      String price,
      String qrCode,
      int quantity,
      String sku,
      String symbol,
      String title
    }):super(
      category: category,
      id: id,
      image: image,
      price: price,
      qrCode: qrCode,
      quantity: quantity,
      sku: sku,
      symbol: symbol,
      title: title
    );

    factory ProductModel2.fromJson(Map<String, dynamic> json) {
        return ProductModel2(
            category: json['category'],
            id: json['id'],
            image: json['image'],
            price: json['price'],
            qrCode: json['qrcode'],
            quantity: json['quantity'],
            sku: json['sku'],
            symbol: json['symbol'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category'] = this.category;
        data['id'] = this.id;
        data['price'] = this.price;
        data['qrcode'] = this.qrCode;
        data['quantity'] = this.quantity;
        data['sku'] = this.sku;
        data['symbol'] = this.symbol;
        data['title'] = this.title;
        data['image'] = this.image;
        return data;
    }
}