import '../repositories/qr_repository.dart';
import '../entities/scanned_data.dart';

class QrCodesHistory {
  final QRRepository repository;

  QrCodesHistory(this.repository);

  Future<List<ScannedData>> call() async {
    try {
      return await repository.getHistory();
    } catch (e) {
      throw Exception(e);
    }
  }
}
