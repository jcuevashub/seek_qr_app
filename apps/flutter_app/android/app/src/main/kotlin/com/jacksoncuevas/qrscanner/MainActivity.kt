package com.jacksoncuevas.qrscanner

import android.content.Intent
import com.jacksoncuevas.qrscanner.auth.AuthApi
import com.jacksoncuevas.qrscanner.auth.AuthApiImpl
import com.jacksoncuevas.qrscanner.qr_scanner.QRScannerApiImpl
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

