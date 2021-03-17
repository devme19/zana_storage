import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class CustomerModel extends CustomerEntity{
    CustomerModel({
      int addBy,
      String address,
      String createdAt,
      String deletedAt,
      String family,
      int id,
      String mobile,
      String name,
      String phone,
      String postalCode,
      int storeId,
      List<Debit> debit,
      String updatedAt}):
        super(
          addBy: addBy,
          address: address,
          createdAt: createdAt,
          deletedAt: deletedAt,
          family: family,
          id: id,
          mobile: mobile,
          name: name,
          phone: phone,
          postalCode: postalCode,
          storeId: storeId,
          updatedAt: updatedAt,
          debit: debit
        );

    factory CustomerModel.fromJson(Map<String, dynamic> json) {
      if(json["data"]!=null)
        json = json["data"];
      else
        if(json["customer"] != null)
          json = json["customer"];
        return CustomerModel(
          addBy: json['add_by'],
            address: json['address'], 
            createdAt: json['created_at'],
            deletedAt: json['deleted_at'],
            family: json['family'], 
            id: json['id'], 
            mobile: json['mobile'], 
            name: json['name'], 
            phone: json['phone'], 
            postalCode: json['postal_code'],
            storeId: json['store_id'],
            updatedAt: json['updated_at'],
          debit: json['debit'] != null ? (json['debit'] as List).map((i) => Debit.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['add_by'] = this.addBy;
        data['address'] = this.address;
        data['created_at'] = this.createdAt;
        data['family'] = this.family;
        data['id'] = this.id;
        data['mobile'] = this.mobile;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['postal_code'] = this.postalCode;
        data['store_id'] = this.storeId;
        data['updated_at'] = this.updatedAt;
        data['deleted_at'] = this.deletedAt;
        return data;
    }
}
class Debit {
    int currency_id;
    double price;
    String symbol;

    Debit({this.currency_id, this.price, this.symbol});

    factory Debit.fromJson(Map<String, dynamic> json) {
        return Debit(
            currency_id: json['currency_id'], 
            price: json['price'], 
            symbol: json['symbol'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['currency_id'] = this.currency_id;
        data['price'] = this.price;
        data['symbol'] = this.symbol;
        return data;
    }
}