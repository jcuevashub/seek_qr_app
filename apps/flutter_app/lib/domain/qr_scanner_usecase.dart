// 📂 packages/qr_scanner/lib/src/usecases/qr_scanner_use_case.dart

import 'package:dartz/dartz.dart';

import '../../../packages/qr_scanner/lib/repositories/qr_scanner_repository_impl.dart'; // For Either (Left for errors, Right for success)

// Use case for scanning a QR code and saving it to the history
class QrScannerUseCase {
  final QrScannerRepositoryImpl repository;

  QrScannerUseCase(this.repository);

  // Executes the QR scan logic and returns an Either with the result or error
  Future<Either<String, String>> execute(String barcode) async {
    try {
      // Interacts with the repository to scan the barcode and save it to history
      return await repository.scanQrCode(barcode);
    } catch (e) {
      return Left(
        "An error occurred: $e",
      ); // Return the error if anything goes wrong
    }
  }
}
