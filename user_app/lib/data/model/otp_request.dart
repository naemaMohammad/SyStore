import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

@JsonSerializable()
class OtpRequest {
  final String email;
  final String otp;

  OtpRequest({
    required this.email,
    required this.otp,
  });

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestToJson(this);
}

@JsonSerializable()
class ResendOtpRequest {
  final String email;

  ResendOtpRequest({
    required this.email,
  });

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpRequestToJson(this);
}