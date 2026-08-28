import 'package:get_storage/get_storage.dart';

class CacheService {
  CacheService._();

  static final CacheService instance = CacheService._();

  final GetStorage _box = GetStorage();

  void save(String key, dynamic value) {
    _box.write(key, value);
    _box.write(
      '\${key}_time',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  bool isExpired(String key, Duration ttl) {
    final time = _box.read('\${key}_time');

    if (time == null) return true;

    final savedTime =
        DateTime.fromMillisecondsSinceEpoch(time);

    return DateTime.now().difference(savedTime) > ttl;
  }

  void clear(String key) {
    _box.remove(key);
    _box.remove('\${key}_time');
  }
}