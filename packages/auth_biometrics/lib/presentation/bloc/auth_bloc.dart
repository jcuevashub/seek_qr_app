import 'package:auth_biometrics/auth_biometrics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class Authenticate extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final bool value;
  Authenticated({required this.value});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser authenticateUser;

  AuthBloc(this.authenticateUser) : super(AuthInitial()) {
    on<Authenticate>((event, emit) async {
      emit(AuthLoading());
      final response = await authenticateUser();
      if (response.success) {
        emit(Authenticated(value: response.success));
      } else {
        emit(AuthError(response.message!));
      }
    });
  }
}
