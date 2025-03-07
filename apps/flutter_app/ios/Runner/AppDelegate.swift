import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        let binaryMessenger = controller.binaryMessenger
        
        let qrScannerApi = QRScannerApiImpl()
        QRScannerApiSetup.setUp(binaryMessenger: binaryMessenger, api: qrScannerApi)
        AuthApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: AuthApiImpl())
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
