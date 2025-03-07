import 'package:flutter/material.dart';

class QRScannerButton extends StatelessWidget {
  final VoidCallback onPressed;

  QRScannerButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.camera_alt),
      label: Text("Escanear QR"),
    );
  }
}
