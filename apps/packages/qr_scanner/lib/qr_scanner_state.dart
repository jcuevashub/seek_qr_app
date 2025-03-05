import 'package:equatable/equatable.dart';

// Clase base para los estados del BLoC
abstract class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object> get props => [];
}

class QrScannerInitial extends QrScannerState {}

class QrScannerLoading extends QrScannerState {}

class QrScannerSuccess extends QrScannerState {
  final String barcode;

  QrScannerSuccess(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class QrScannerError extends QrScannerState {
  final String message;

  QrScannerError(this.message);

  @override
  List<Object> get props => [message];
}
