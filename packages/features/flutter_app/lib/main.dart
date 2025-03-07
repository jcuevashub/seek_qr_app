import 'package:app_common/utils/app_constants.dart';
import 'package:auth_biometrics/data/repositories/auth_repository_impl.dart';
import 'package:auth_biometrics/domain/usecases/authenticate_user.dart';
import 'package:auth_biometrics/presentation/bloc/auth_bloc.dart';
import 'package:auth_biometrics/presentation/pages/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_scanner/domain/usecases/qr_codes_history.dart';
import 'package:qr_scanner/qr_scanner.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScannedDataAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => QRBloc(
                ScanQRCode(QRRepositoryImpl()),
                QrCodesHistory(QRRepositoryImpl()),
              ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthenticateUser(AuthRepositoryImpl())),
        ),
      ],
      child: MaterialApp(
        home: AuthScreen(),
        debugShowCheckedModeBanner: false,
        routes: {AppRoutes.qrScanner: (context) => QRScannerScreen()},
      ),
    );
  }
}
