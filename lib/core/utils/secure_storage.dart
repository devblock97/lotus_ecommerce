import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String TOKEN = 'TOKEN';
const String NONCE = 'NONCE';

class SecureStorage {

  final _storage = const FlutterSecureStorage();

  Future<void> writeToken(String? value) async {
    await _storage.write(key: TOKEN, value: value);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: TOKEN);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: TOKEN);
  }

  ///
  ///
  ///
  Future<void> writeNonce(String value) async {
    await _storage.write(key: NONCE, value: value);
  }

  Future<String?> readNonce() async {
    return await _storage.read(key: NONCE);
  }

  Future<void> removeNonce() async {
    await _storage.delete(key: NONCE);
  }

}