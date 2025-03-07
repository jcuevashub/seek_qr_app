import 'package:auth_biometrics/presentation/widgets/biometric_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Autenticación")),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacementNamed('/qr_screen');
            } else if (state is AuthError) {}
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return CircularProgressIndicator();
            }
            return BiometricAuthButton(
              onPressed: () => context.read<AuthBloc>().add(Authenticate()),
            );
          },
        ),
      ),
    );
  }
}
