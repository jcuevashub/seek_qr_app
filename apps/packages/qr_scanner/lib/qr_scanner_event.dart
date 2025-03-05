import 'package:equatable/equatable.dart';

// Clase base de evento
abstract class QrScannerEvent extends Equatable {
  const QrScannerEvent();

  @override
  List<Object> get props => [];
}

// Evento para iniciar el escaneo de un código QR
class ScanQrCodeEvent extends QrScannerEvent {
  final String barcode;

  const ScanQrCodeEvent(this.barcode);

  @override
  List<Object> get props => [barcode];
}
