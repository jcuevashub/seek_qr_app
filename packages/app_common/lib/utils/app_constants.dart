abstract class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String qrScanner = '/qrScanner';
}

abstract class AppStrings {
  // General
  static const String appName = 'QR Scanner App';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String error = 'An error occurred';

  // Authentication
  static const String loginTitle = 'Login';
  static const String loginButton = 'Sign In';
  static const String biometricPrompt =
      'Tap to authenticate using Face ID or Fingerprint';
  static const String biometricError = 'Biometric authentication failed';
  static const String pinPrompt = 'Enter your PIN';

  // QR Scanner
  static const String scanQR = 'Scan QR Code';
  static const String scanning = 'Scanning...';
  static const String scanError = 'Failed to scan QR code';
  static const String noQrCodesScanned = 'No QR codes scanned';

  // Profile
  static const String profileTitle = 'My Profile';
  static const String logout = 'Logout';
}
