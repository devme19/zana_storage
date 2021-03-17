import 'package:zana_storage/features/domain/entities/user_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class UserInfoModel extends UserInfoEntity{

    UserInfoModel({
      package,
      address,
      admin,
      id,
      logo,
      minQuantity,
      phone,
      registrationNumber,
      skuPrefix,
      skuStart,
      title,
      user
    }):super(
      package: package,
      address: address,
      admin: admin,
      id: id,
      logo: logo,
      minQuantity: minQuantity,
      phone: phone,
      registrationNumber: registrationNumber,
      skuPrefix: skuPrefix,
      skuStart: skuStart,
      title: title,
      user: user
    );

    factory UserInfoModel.fromJson(Map<String, dynamic> json) {
      var js =json['store'];
      if(js == null)
        js = json;
        return UserInfoModel(
            package: js['package'],
            address: js['address'],
            // admin: js['admin'],
            id: js['id'],
            logo: js['logo'],
            minQuantity: js['min_quantity'],
            phone: js['phone'],
            registrationNumber: js['registration_number'],
            skuPrefix: js['sku_prefix'],
            skuStart: js['sku_start'],
            title: js['title'],
            user: js['user'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['package'] = this.package;
        data['address'] = this.address;
        data['admin'] = this.admin;
        data['id'] = this.id;
        data['logo'] = this.logo;
        data['min_quantity'] = this.minQuantity;
        data['phone'] = this.phone;
        data['registration_number'] = this.registrationNumber;
        data['sku_prefix'] = this.skuPrefix;
        data['sku_start'] = this.skuStart;
        data['title'] = this.title;
        data['user'] = this.user;
        return data;
    }
}