import 'package:pigeon/pigeon.dart';

class QRCode {
  String? value;
}

@HostApi()
abstract class QRScannerApi {
  @async
  QRCode scanQRCode();
}
