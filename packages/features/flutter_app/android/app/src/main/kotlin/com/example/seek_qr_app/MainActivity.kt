package com.example.seek_qr_app

import android.content.Intent
import com.example.seek_qr_app.auth.AuthApi
import com.example.seek_qr_app.auth.AuthApiImpl
import com.example.seek_qr_app.qr_scanner.QRScannerApiImpl
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    private lateinit var qrScannerApiImpl: QRScannerApiImpl

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        AuthApi.setUp(flutterEngine.dartExecutor.binaryMessenger, AuthApiImpl(this))

        qrScannerApiImpl = QRScannerApiImpl(this)
        QRScannerApi.setUp(flutterEngine.dartExecutor.binaryMessenger, qrScannerApiImpl)
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        qrScannerApiImpl.handleActivityResult(requestCode, resultCode, data)
    }
}

