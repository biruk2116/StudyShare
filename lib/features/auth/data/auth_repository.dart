import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  AuthRepository({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 950));
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String department,
    required String year,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1100));
  }

  Future<void> saveRememberedEmail(String? email) async {
    if (email == null || email.isEmpty) {
      await _storage.delete(key: 'studyshare.remembered_email');
    } else {
      await _storage.write(key: 'studyshare.remembered_email', value: email);
    }
  }

  Future<String?> readRememberedEmail() =>
      _storage.read(key: 'studyshare.remembered_email');
}
