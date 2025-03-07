import 'package:auth_biometrics/data/native/auth_api.dart';

abstract class AuthRepository {
  Future<AuthResult> authenticate();
}
