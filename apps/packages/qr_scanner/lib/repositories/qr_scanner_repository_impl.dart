// 📂 packages/qr_scanner/lib/src/repositories/qr_scanner_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart'; // For Either

abstract class QrScannerRepository {
  Future<Either<String, String>> scanQrCode(String barcode);
  Future<void> saveToHistory(String barcode);
}

class QrScannerRepositoryImpl implements QrScannerRepository {
  Box<String>? _historyBox;

  Future<void> init() async {
    // Ensure that the box is opened
    _historyBox = await Hive.openBox<String>('historyBox');
  }

  @override
  Future<Either<String, String>> scanQrCode(String barcode) async {
    try {
      if (_historyBox == null) {
        await init();
      }
      await saveToHistory(barcode); // Save barcode to history
      return Right(barcode); // Return the scanned barcode as success
    } catch (e) {
      return Left(
        'Error while saving the QR code: $e',
      ); // Return an error message on failure
    }
  }

  @override
  Future<void> saveToHistory(String barcode) async {
    if (_historyBox == null) {
      await init();
    }
    await _historyBox!.add(barcode);
  }
}
