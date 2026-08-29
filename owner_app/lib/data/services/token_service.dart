// lib/data/services/token_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Unified access to the merchant auth token.
///
/// All three merged subsystems (lana auth, lilav product/store, ranim
/// orders/reviews) previously handled the token differently — lana wrote it
/// to GetStorage under 'token', ranim read that same key, and lilav shipped a
/// hardcoded literal. This service centralizes storage on the existing
/// 'token' key (no storage restructuring) so every layer reads/writes the
/// same value and the shared Dio interceptor can inject it automatically.
class TokenService extends GetxService {
  static const _kToken = 'token';
  static const _kUserData = 'user_data';
final RxnString _token = RxnString();
  final GetStorage _box = GetStorage();

  // جلب التوكن الخام
  String? get token {
    final t = _box.read<String>(_kToken);
    print("🔑 [TokenService] Current Raw Token in Storage: '$t'");
    return t;
  }

  bool get hasToken {
    final t = token;
    return t != null && t.trim().isNotEmpty;
  }
  @override
  void onInit() {
    super.onInit();
    _loadTokenFromStorage();
  }

  // قراءة التوكن عند إقلاع الخدمة
  void _loadTokenFromStorage() {
    final savedToken = _box.read<String>(_kToken);
    _token.value = savedToken;
    print('🔑 [TokenService] Loaded Token on Startup: $savedToken');
  }

  /// يضمن إرجاع 'Bearer <token>' دون تكرار كلمة Bearer إن كانت مخزنة مسبقاً
  String get bearer {
    final rawToken = token;
    if (rawToken == null || rawToken.trim().isEmpty) return '';
    
    final cleanToken = rawToken.trim();
    if (cleanToken.startsWith('Bearer ')) {
      return cleanToken;
    }
    return 'Bearer $cleanToken';
  }
 Future<void> save(String newToken) async {
    print("💾 [TokenService] Saving new token: $newToken");
     _token.value = newToken;
    await _box.write(_kToken, newToken);
  }

  Future<void> clear() async {
    print("🗑️ [TokenService] Clearing Token & User Data!");
    _token.value = null;
    await _box.remove(_kToken);
    await _box.remove(_kUserData);
  }
}
