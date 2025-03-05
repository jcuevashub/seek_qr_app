import 'package:pigeon/pigeon.dart';

class QRCode {
  final String value;

  QRCode(this.value);
}

@HostApi()
abstract class QRScannerApi {
  QRCode? scanQRCode();
}
