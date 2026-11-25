import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repository);
  final AuthRepository _repository;
  bool _loading = false;
  bool get isLoading => _loading;

  Future<void> _run(Future<void> Function() action) async {
    if (_loading) return;
    _loading = true;
    notifyListeners();
    try {
      await action();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) =>
      _run(() => _repository.signIn(email: email, password: password));

  Future<void> signUp({
    required String name,
    required String email,
    required String department,
    required String year,
    required String password,
  }) => _run(
    () => _repository.signUp(
      name: name,
      email: email,
      department: department,
      year: year,
      password: password,
    ),
  );
}
