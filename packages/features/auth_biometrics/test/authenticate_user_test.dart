import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:auth_biometrics/domain/usecases/authenticate_user.dart';
import 'package:auth_biometrics/domain/entities/auth_result.dart';
import 'package:auth_biometrics/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthenticateUser usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthenticateUser(mockRepository);
  });

  test('Debe autenticar exitosamente', () async {
    final authResult = AuthResult(success: true, message: "Autenticado");
    // when(mockRepository.authenticate()).thenAnswer((_) async => authResult.success!!);

    final result = await usecase.call();

    expect(result.success, true);
    expect(result.message, "Autenticado");
    verify(mockRepository.authenticate());
  });
}
