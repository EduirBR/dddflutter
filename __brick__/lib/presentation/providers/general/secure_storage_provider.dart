import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> setValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<bool> exists(String key) async {
    return await _storage.containsKey(key: key);
  }

  Future<Map<String, String>> getAll() async {
    return await _storage.readAll();
  }
}
