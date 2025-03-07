import 'package:app_common/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/domain/usecases/qr_codes_history.dart';

import '../../domain/usecases/scan_qr_code.dart';
import '../../domain/entities/scanned_data.dart';

abstract class QREvent {}

class ScanQR extends QREvent {}

class ScanHistoryQR extends QREvent {}

abstract class QRState {}

class QRInitial extends QRState {}

class QRLoading extends QRState {}

class QRScanned extends QRState {
  final ScannedData data;
  QRScanned(this.data);
}

class QRScannedList extends QRState {
  final List<ScannedData> data;
  QRScannedList(this.data);
}

class QRError extends QRState {
  final String message;
  QRError(this.message);
}

class QRBloc extends Bloc<QREvent, QRState> {
  final ScanQRCode scanQRCode;
  final QrCodesHistory qrCodeHistory;

  QRBloc(this.scanQRCode, this.qrCodeHistory) : super(QRInitial()) {
    on<ScanQR>(_onScanQR);
    on<ScanHistoryQR>(_onScanHistoryQR);
  }

  Future<void> _onScanQR(ScanQR event, Emitter<QRState> emit) async {
    emit(QRLoading());
    try {
      final data = await scanQRCode();
      emit(QRScanned(data));
    } catch (e) {
      emit(QRError(AppStrings.scanError));
    }
  }

  Future<void> _onScanHistoryQR(
    ScanHistoryQR event,
    Emitter<QRState> emit,
  ) async {
    emit(QRLoading());
    try {
      final data = await qrCodeHistory();
      emit(QRScannedList(data));
    } catch (e) {
      emit(QRError(AppStrings.error));
    }
  }
}
