import 'package:flutter/material.dart';

class BiometricAuthButton extends StatelessWidget {
  final VoidCallback onPressed;

  BiometricAuthButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.fingerprint, size: 100),
      onTap: onPressed,
    );
  }
}
