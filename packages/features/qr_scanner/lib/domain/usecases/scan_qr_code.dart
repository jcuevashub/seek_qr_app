import '../repositories/qr_repository.dart';
import '../entities/scanned_data.dart';

class ScanQRCode {
  final QRRepository repository;

  ScanQRCode(this.repository);

  Future<ScannedData> call() async {
    try {
      return await repository.scanQR();
    } catch (e) {
      throw Exception(e);
    }
  }
}
