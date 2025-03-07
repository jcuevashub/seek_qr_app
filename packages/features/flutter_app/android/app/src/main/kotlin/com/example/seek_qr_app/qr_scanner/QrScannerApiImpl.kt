package com.example.seek_qr_app.qr_scanner

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.example.seek_qr_app.QRCode
import com.example.seek_qr_app.QRScannerApi
import com.google.zxing.integration.android.IntentIntegrator
import com.google.zxing.integration.android.IntentResult
import com.journeyapps.barcodescanner.ScanOptions

class QRScannerApiImpl(private val activity: Activity) : QRScannerApi {
    private var resultCallback: ((Result<QRCode>) -> Unit)? = null

    override fun scanQRCode(callback: (Result<QRCode>) -> Unit) {
        resultCallback = callback
        try {
            val integrator = IntentIntegrator(activity)
            integrator.setDesiredBarcodeFormats(ScanOptions.QR_CODE)
            integrator.setBeepEnabled(false)
            integrator.setOrientationLocked(true)

            integrator.initiateScan()
        } catch (e: Exception) {
            Log.e("QRScanner", "Failed to start QR scanner", e)
            callback(Result.failure(Exception("INITIATE_SCAN_FAILED: Failed to start QR scanning")))
        }
    }

    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        val intentResult: IntentResult? = IntentIntegrator.parseActivityResult(requestCode, resultCode, data)

        if (intentResult?.contents != null) {
            val qrCode = QRCode(intentResult.contents)
            resultCallback?.invoke(Result.success(qrCode))
        } else {
            Log.e("QRScanner", "Scan failed or was canceled")
            resultCallback?.invoke(Result.failure(Exception("SCAN_FAILED: QR scan failed or canceled")))
        }

        resultCallback = null
    }
}
