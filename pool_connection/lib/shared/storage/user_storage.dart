import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  Future<void> setPin(String value) async {
    await storage.write(key: 'pinUser', value: value);
  }

  Future<String?> getPin() async {
    final data = await storage.read(key: 'pinUser');
    return data;
  }

  Future<void> deletePin() async {
    await storage.delete(key: 'pinUser');
  }

  Future<void> setSecurityWord(String value) async {
    await storage.write(key: 'securityWord', value: value);
  }

  Future<String?> getSecurityWord() async {
    final data = await storage.read(key: 'securityWord');
    return data;
  }
}
