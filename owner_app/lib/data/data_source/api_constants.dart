// lib/core/constants/api_constants.dart
class ApiConstants {
  // ✅ Unified base URL for the whole app (all three merged subsystems).
  static const String baseUrl = 'http://192.168.43.121:8000/api';

  static const String imageBaseUrl = 'http://192.168.43.121:8000/storage';

  static String getFullImageUrl(String? imagePath) {
  if (imagePath == null || imagePath.isEmpty) return '';
  if (imagePath.startsWith('http')) return imagePath;

  // تنظيف أي سلاش إضافية في بداية مسار الصورة
  final cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

  // إذا كان المسار يبدأ بـ Uploads/ نضيف قبله storage/ ونربطه بـ baseUrl الرئيسي
  if (cleanPath.startsWith('Uploads/') || cleanPath.startsWith('uploads/')) {
    return '${ApiConstants.imageBaseUrl}/$cleanPath';
  }

  // إذا كان المسار يحتوي أساساً على كلمة storage
  if (cleanPath.startsWith('storage/')) {
    return 'http://192.168.43.121:8000/$cleanPath';
  }

  return '${ApiConstants.imageBaseUrl}/$cleanPath';
}
}
