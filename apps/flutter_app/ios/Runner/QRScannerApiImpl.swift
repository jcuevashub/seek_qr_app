import AVFoundation
import Flutter
import UIKit

class FlutterError: Error {
    let code: String
    let message: String?
    let details: Any?

    init(code: String, message: String? = nil, details: Any? = nil) {
        self.code = code
        self.message = message
        self.details = details
    }
}

class QRScannerApiImpl: NSObject, QRScannerApi {
    private var result: FlutterResult?

    func scanQRCode(completion: @escaping (Result<QRCode, any Error>) -> Void) {
        DispatchQueue.main.async {
            guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
                completion(.failure(FlutterError(code: "NO_VIEW_CONTROLLER", message: "Could not find root view controller", details: nil)))
                return
            }
            
            let scannerVC = QRScannerViewController()
            scannerVC.onQRCodeScanned = { scannedCode in
                let qrCode = QRCode(value: scannedCode)
                completion(.success(qrCode))
            }
            
            viewController.present(scannerVC, animated: true, completion: nil)
        }
    }
}
