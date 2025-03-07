import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_scanner/domain/entities/scanned_data.dart';

import '../lib/domain/repositories/qr_repository.dart';
import '../lib/domain/usecases/scan_qr_code.dart';

class MockQRRepository extends Mock implements QRRepository {}

void main() {
  late ScanQRCode usecase;
  late MockQRRepository mockRepository;

  setUp(() {
    mockRepository = MockQRRepository();
    usecase = ScanQRCode(mockRepository);
  });

  test('Debe escanear un QR correctamente', () async {
    final scannedData = ScannedData(
      content: 'https://example.com',
      timestamp: DateTime.now(),
    );
    when(mockRepository.scanQR()).thenAnswer((_) async => scannedData);

    final result = await usecase.call();

    expect(result.content, "https://example.com");
    verify(mockRepository.scanQR());
  });
}
