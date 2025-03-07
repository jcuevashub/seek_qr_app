# dart run pigeon \
#   --input qr_scanner_api.dart \
#   --dart_out lib/qr_scanner_api.dart \
#   --kotlin_out android/app/src/main/kotlin/com/jacksoncuevas/qrscanner/QRScannerApi.kt \
#   --swift_out ios/Runner/QRScannerApi.swift \
#   --kotlin_package com.jacksoncuevas.qrscanner 

dart run pigeon \
  --input auth_api.dart \
  --dart_out lib/auth_api.dart \
  --kotlin_out android/app/src/main/kotlin/com/jacksoncuevas/qrscanner/AuthApi.kt \
  --swift_out ios/Runner/AuthApi.swift \
  --kotlin_package com.jacksoncuevas.qrscanner
