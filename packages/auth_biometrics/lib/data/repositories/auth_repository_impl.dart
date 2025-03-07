import 'package:auth_biometrics/data/native/auth_api.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api = AuthApi();

  @override
  Future<AuthResult> authenticate() async {
    try {
      final authenticated = await _api.authenticate();

      return AuthResult(
        success: authenticated.success,
        message: authenticated.message,
      );
    } catch (e) {
      return AuthResult(success: false, message: "Error: ${e.toString()}");
    }
  }
}
