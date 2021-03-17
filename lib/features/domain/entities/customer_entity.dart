import 'package:zana_storage/features/data/model/customer_model.dart';

class CustomerEntity{
  int id;
  int storeId;
  int addBy;
  String name;
  String family;
  String mobile;
  String address;
  String postalCode;
  String phone;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<Debit> debit;
  CustomerEntity({
    this.id,
    this.storeId,
    this.addBy,
    this.name,
    this.family,
    this.mobile,
    this.address,
    this.postalCode,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.debit
});
}