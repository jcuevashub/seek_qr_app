import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../packages/qr_scanner/lib/qr_scanner_bloc.dart';
import '../../../../packages/qr_scanner/lib/qr_scanner_state.dart';
import '../../../../packages/qr_scanner/lib/repositories/qr_scanner_repository_impl.dart';
import '../../domain/qr_scanner_usecase.dart';

// Pantalla para escanear códigos QR
class QrScannerScreen extends StatelessWidget {
  final qrScannerUseCase = QrScannerUseCase(QrScannerRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear Código QR')),
      body: BlocProvider(
        create: (context) => QrScannerBloc(qrScannerUseCase),
        child: const QrScannerView(),
      ),
    );
  }
}

class QrScannerView extends StatefulWidget {
  const QrScannerView({Key? key}) : super(key: key);

  @override
  _QrScannerViewState createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Mobile Scanner widget to handle QR scanning
        Expanded(
          child: MobileScanner(
            controller: controller,
            // onDetect: (barcode, args) {
            //   // Llamada al BLoC para manejar el escaneo
            //   final barcodeValue = barcode.rawValue;
            //   if (barcodeValue != null) {
            //     // Emitir evento al BLoC cuando se detecta un código QR
            //     context.read<QrScannerBloc>().add(ScanQrCode(barcodeValue));
            //   }
            // },
          ),
        ),
        // BlocBuilder to handle different states
        BlocBuilder<QrScannerBloc, QrScannerState>(
          builder: (context, state) {
            if (state is QrScannerLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QrScannerSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '¡Código QR Escaneado!\n${state.barcode}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else if (state is QrScannerError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            return SizedBox.shrink(); // Si no hay estado, no mostrar nada
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller when done
    super.dispose();
  }
}
