import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/qr_bloc.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QRBloc>().add(ScanHistoryQR());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escáner QR")),
      body: Center(
        child: BlocConsumer<QRBloc, QRState>(
          listener: (context, state) {
            if (state is QRScanned) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Escaneado: ${state.data.content}")),
              );
              context.read<QRBloc>().add(ScanHistoryQR());
            }
          },
          builder: (context, state) {
            if (state is QRLoading) {
              return CircularProgressIndicator();
            } else if (state is QRScannedList) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child:
                          state.data.isEmpty
                              ? Center(child: Text("No QR codes scanned"))
                              : ListView.builder(
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(state.data[index].content),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              child: GestureDetector(
                child: Icon(Icons.qr_code_scanner, size: 100),
                onTap: () => context.read<QRBloc>().add(ScanQR()),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => context.read<QRBloc>().add(ScanQR()),
        child: Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 9,
        color: Colors.greenAccent,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
      ),
    );
  }
}
