import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';

import '../lib/auth_biometrics.dart';

class MockLocalAuth extends Mock implements LocalAuthentication {}

void main() {
  late AuthBloc authBloc;
  late MockLocalAuth mockLocalAuth;

  setUp(() {
    mockLocalAuth = MockLocalAuth();
    authBloc = AuthBloc(mockLocalAuth);
  });

  test('Debe autenticar correctamente con biometría', () async {
    when(
      mockLocalAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
      ),
    ).thenAnswer((_) async => true);

    final result = await authBloc.authenticate();
    expect(result, true);
  });

  test('Debe autenticar correctamente con PIN', () {
    final result = authBloc.authenticateWithPin('1234');
    expect(result, true);
  });
}
