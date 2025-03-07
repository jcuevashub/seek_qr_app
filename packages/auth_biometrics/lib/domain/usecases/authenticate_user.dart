import '../../data/native/auth_api.dart';
import '../repositories/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository repository;

  AuthenticateUser(this.repository);

  Future<AuthResult> call() async {
    return await repository.authenticate();
  }
}
