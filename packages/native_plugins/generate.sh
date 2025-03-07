# dart run pigeon \
#   --input qr_scanner_api.dart \
#   --dart_out lib/qr_scanner_api.dart \
#   --kotlin_out android/app/src/main/kotlin/com/example/seek_qr_app/QRScannerApi.kt \
#   --swift_out ios/Runner/QRScannerApi.swift \
#   --kotlin_package com.example.seek_qr_app 

dart run pigeon \
  --input auth_api.dart \
  --dart_out lib/auth_api.dart \
  --kotlin_out android/app/src/main/kotlin/com/example/seek_qr_app/AuthApi.kt \
  --swift_out ios/Runner/AuthApi.swift \
  --kotlin_package com.example.seek_qr_app 
