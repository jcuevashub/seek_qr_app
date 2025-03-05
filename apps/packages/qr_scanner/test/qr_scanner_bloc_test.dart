import 'package:hive_ce/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  // late QrScannerBloc qrScannerBloc;
  // late MockBox mockBox;

  // setUp(() {
  //   mockBox = MockBox();
  //   when(mockBox.values).thenReturn([]);
  //   qrScannerBloc = QrScannerBloc(mockBox);
  // });

  // test('Debe agregar un código escaneado al historial', () {
  //   final barcode = 'https://flutter.dev';
  //   qrScannerBloc.scanCode(Barcode(rawValue: barcode));
  //   expect(qrScannerBloc.getHistory().contains(barcode), true);
  // });
}
