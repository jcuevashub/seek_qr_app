import 'package:local_auth/local_auth.dart';

class AuthBloc {
  final LocalAuthentication _localAuth;

  AuthBloc(this._localAuth);

  Future<bool> authenticate() async {
    return await _localAuth.authenticate(
      localizedReason: 'Por favor, autentícate',
    );
  }

  bool authenticateWithPin(String pin) {
    // Lógica para la autenticación con PIN
    return pin == '1234'; // PIN de ejemplo
  }
}
