// lib/app/data/models/merchant/merchant_login_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'merchant_login_request.g.dart';

@JsonSerializable()
class MerchantLoginRequest {
  final String email;
  final String password;

  MerchantLoginRequest({
    required this.email,
    required this.password,
  });

  factory MerchantLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$MerchantLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantLoginRequestToJson(this);
}