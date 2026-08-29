import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_app/data/data_source/api_constants.dart';

class ApiConfig {
  const ApiConfig._();

  static const String host = ApiConstants.host;

  static const String apiBaseUrl = ApiConstants.baseUrl;

  static const String storageBaseUrl = ApiConstants.imageBaseUrl;

  static const Duration defaultTimeout = ApiConstants.defaultTimeout;

  static const Duration aiSearchTimeout = ApiConstants.aiSearchTimeout;
}


String apiErrorMessage(Object? e, String fallbackKey) {
  if (e is DioException) {
    final msg = e.message;
    if (msg != null && msg.trim().isNotEmpty) {
      return msg;
    }
  }
  return fallbackKey.tr;
}

bool boolCoerce(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  if (v is num) return v != 0;
  return v.toString().toLowerCase() == 'true' || v.toString() == '1';
}


double priceCoerce(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0;
}

double? doubleNullableCoerce(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

String getFullImageUrl(String? path) {
  if (path == null) return '';
  final p = path.trim();
  if (p.isEmpty) return '';
  if (p.startsWith('http://') || p.startsWith('https://')) return p;

  final relative = p.startsWith('/') ? p.substring(1) : p;

  final needsStorage =
      !relative.toLowerCase().startsWith('storage/') &&
      (relative.startsWith('Uploads/') || relative.startsWith('uploads/'));

  final built = needsStorage
      ? '${ApiConfig.host}/storage/$relative'
      : '${ApiConfig.host}/$relative';

  return built.replaceAllMapped(RegExp(r'(?<!:)//'), (m) => '/');
}


String imageUrl(String? p) => getFullImageUrl(p);
