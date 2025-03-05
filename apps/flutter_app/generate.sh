dart run pigeon \              
  --input pigeons/qr_scanner_api.dart \
  --dart_out apps/native_plugins/qr_scanner/lib \
  --kotlin_out android/app/src/main/kotlin/com/example/seek_qr_app/QRScannerApi.kt \
  --swift_out ios/Runner/QRScannerApi.swift \
  --kotlin_package com.example.seek_qr_app 
