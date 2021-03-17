import 'package:zana_storage/features/domain/entities/login_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class LoginModel extends LoginEntity {

  LoginModel({
    String accessToken,
  }) : super(
    accessToken: accessToken
  );
  factory LoginModel.fromJson(Map<String, dynamic> json){ return
    LoginModel(
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken':accessToken,
  };
}