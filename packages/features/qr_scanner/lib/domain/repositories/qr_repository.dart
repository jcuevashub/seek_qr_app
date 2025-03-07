import 'package:qr_scanner/domain/entities/scanned_data.dart';

abstract class QRRepository {
  Future<ScannedData> scanQR();
  Future<List<ScannedData>> getHistory();
}
