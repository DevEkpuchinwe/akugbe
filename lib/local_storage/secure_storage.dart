import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _singleton = SecureStorage._privateConstructor();

  factory SecureStorage() => _singleton;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final IOSOptions _iosOptions =
      const IOSOptions(accessibility: KeychainAccessibility.unlocked);

  late final AndroidOptions _androidOptions = const AndroidOptions();

  SecureStorage._privateConstructor();

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }


  Future<bool?> getBool(String key) async {
    var d =  await _storage.read(key: key);
   // bool boolValue = d ;

  }
  Future<Map<String, String>> getAllValues() async {
    return await _storage.readAll();
  }

  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAllValues() async {
    await _storage.deleteAll();
  }

  Future<void> writeValue(String key, String value) async {
    await _storage.write(key: key, value: value, iOptions: _iosOptions);
  }

  Future<void> writeBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString(), iOptions: _iosOptions);
  }



}
