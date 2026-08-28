import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class TokenService {
  TokenService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  final GetStorage _box = GetStorage();

  static const String _secureKey = 'auth_token';
  static const String _boxKey = 'token';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _secureKey, value: token);
    await _box.write(_boxKey, token);
  }

  Future<String?> readToken() async {
    final saved = await _storage.read(key: _secureKey);
    if (saved != null && saved.isNotEmpty) return saved;
    final boxed = _box.read<String>(_boxKey);
    if (boxed != null && boxed.isNotEmpty) return boxed;
    return null;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _secureKey);
    await _box.remove(_boxKey);
    await _box.remove('user_data');
  }

  Future<bool> get hasToken async => (await readToken())?.isNotEmpty ?? false;

  bool get hasTokenSync => _box.read<String>(_boxKey)?.isNotEmpty ?? false;
}
