import 'package:pigeon/pigeon.dart';

class AuthResult {
  bool success;
  String? message;

  AuthResult(this.success, {this.message});
}

@HostApi()
abstract class AuthApi {
  @async
  AuthResult authenticate();
}
