import 'package:flutter/src/services/binary_messenger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner/data/native/qr_scanner_api.dart';
import 'package:qr_scanner/data/repositories/qr_repository_impl.dart';
import 'package:qr_scanner/domain/entities/scanned_data.dart';

class FakeQRScannerApi implements QRScannerApi {
  @override
  Future<QRCode> scanQRCode() async {
    return QRCode(value: "https://example.com");
  }

  @override
  @override
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  @override
  String get pigeonVar_messageChannelSuffix => '';
}

class FakeQRRepositoryImpl extends QRRepositoryImpl {
  final List<ScannedData> fakeHistory = [];

  @override
  Future<void> init() async {}

  @override
  Future<ScannedData> scanQR() async {
    final scannedData = ScannedData(
      content: "https://fake-url.com",
      timestamp: DateTime.now(),
    );
    await saveToHistory(scannedData);
    return scannedData;
  }

  @override
  Future<List<ScannedData>> getHistory() async {
    return fakeHistory;
  }

  @override
  Future<void> saveToHistory(ScannedData data) async {
    fakeHistory.add(data);
  }
}

void main() {
  late FakeQRRepositoryImpl fakeQRRepository;

  setUp(() {
    fakeQRRepository = FakeQRRepositoryImpl();
  });

  group('Fake QRRepositoryImpl tests', () {
    test(
      'scanQR should return fake scanned data and save to fake history',
      () async {
        // Act
        final result = await fakeQRRepository.scanQR();

        // Assert
        expect(result.content, "https://fake-url.com");
        expect(result.timestamp, isA<DateTime>());
        expect(fakeQRRepository.fakeHistory.length, 1);
        expect(fakeQRRepository.fakeHistory[0].content, "https://fake-url.com");
      },
    );

    test('getHistory should return list of fake scanned data', () async {
      // Arrange
      final fakeScannedData = ScannedData(
        content: 'https://another-fake-url.com',
        timestamp: DateTime.now(),
      );
      await fakeQRRepository.saveToHistory(fakeScannedData);

      // Act
      final history = await fakeQRRepository.getHistory();

      // Assert
      expect(history.length, 1);
      expect(history[0].content, 'https://another-fake-url.com');
    });

    test('saveToHistory should add data to fake history', () async {
      // Arrange
      final scannedData = ScannedData(
        content: 'https://test-url.com',
        timestamp: DateTime.now(),
      );

      // Act
      await fakeQRRepository.saveToHistory(scannedData);

      // Assert
      expect(fakeQRRepository.fakeHistory.length, 1);
      expect(fakeQRRepository.fakeHistory[0].content, 'https://test-url.com');
    });
  });
}
