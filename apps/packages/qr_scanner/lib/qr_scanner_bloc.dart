import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_app/lib/domain/qr_scanner_usecase.dart';
import 'qr_scanner_event.dart';
import 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  final QrScannerUseCase qrScannerUseCase;

  QrScannerBloc(this.qrScannerUseCase) : super(QrScannerInitial());

  Stream<QrScannerState> mapEventToState(QrScannerEvent event) async* {
    if (event is ScanQrCodeEvent) {
      yield QrScannerLoading(); // Show loading when scanning

      // Call the use case to handle the QR scan logic
      final result = await qrScannerUseCase.execute(event.barcode);

      // Yield different states based on the result from the use case
      yield result.fold(
        (failure) => QrScannerError(failure), // Error in case of failure
        (barcode) =>
            QrScannerSuccess(barcode), // Success with the scanned barcode
      );
    }
  }
}
