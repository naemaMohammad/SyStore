import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(defaultValue: false, fromJson: _boolFromJson)
  final bool success;

  final String? message;
  final String? token;

  @JsonKey(name: 'user')
  final UserData? userData;

  AuthResponse({
    required this.success,
    this.message,
    this.token,
    this.userData,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

bool _boolFromJson(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value.toLowerCase() == 'true';
  return false;
}

bool? _boolFromJsonNullable(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value.toLowerCase() == 'true';
  return null;
}

@JsonSerializable()
class UserData {
  final int? id;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final String? email;
  final String? phone;

  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;

  @JsonKey(name: 'is_blocked', fromJson: _boolFromJsonNullable)
  final bool? isBlocked;

  UserData({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.isBlocked,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
