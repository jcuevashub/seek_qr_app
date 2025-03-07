/// lib/data/repositories/qr_repository_impl.dart
import 'package:hive/hive.dart';
import 'package:qr_scanner/data/native/qr_scanner_api.dart';
import '../../domain/entities/scanned_data.dart';
import '../../domain/repositories/qr_repository.dart';

class QRRepositoryImpl implements QRRepository {
  final QRScannerApi _api = QRScannerApi();
  Box<ScannedData>? historyBox;

  Future<void> init() async {
    historyBox = await Hive.openBox<ScannedData>('qr_history');
  }

  @override
  Future<ScannedData> scanQR() async {
    try {
      final result = await _api.scanQRCode();
      final scannedData = ScannedData(
        content: result.value!,
        timestamp: DateTime.now(),
      );
      await _saveToHistory(scannedData);
      return scannedData;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _saveToHistory(ScannedData data) async {
    if (historyBox == null) {
      await init();
    }
    await historyBox!.add(data);
  }

  @override
  Future<List<ScannedData>> getHistory() async {
    if (historyBox == null) {
      await init();
    }
    return historyBox!.values.toList();
  }
}
