import 'package:app_common/app_common.dart';
import 'package:flutter/material.dart';

class BiometricAuthButton extends StatelessWidget {
  final VoidCallback onPressed;

  BiometricAuthButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fingerprint, size: 100),
          Text(AppStrings.biometricPrompt, style: TextStyle(fontSize: 16)),
        ],
      ),
      onTap: onPressed,
    );
  }
}
