import 'package:auth_biometrics/data/native/auth_api.dart';
import 'package:auth_biometrics/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthResult> authenticate() async {
    return AuthResult(success: true, message: "Authenticated");
  }
}

void main() {
  late FakeAuthRepositoryImpl fakeAuthRepository;

  setUp(() {
    fakeAuthRepository = FakeAuthRepositoryImpl();
  });

  group('Fake AuthRepositoryImpl tests', () {
    test('should authenticate successfully', () async {
      // Act: Call the authenticate method on the fake repository
      final result = await fakeAuthRepository.authenticate();

      // Assert: Verify the result
      expect(result.success, true);
      expect(result.message, "Authenticated");
    });

    test('should authenticate unsuccessfully (simulate failure)', () async {
      // Create a fake AuthRepositoryImpl that simulates failure
      final fakeFailureAuthRepository = FakeAuthRepositoryImplFailure();

      // Act: Call the authenticate method on the fake failure repository
      final result = await fakeFailureAuthRepository.authenticate();

      // Assert: Verify the result for failure
      expect(result.success, false);
      expect(result.message, "Error: Authentication failed");
    });
  });
}

// Fake failure implementation of AuthRepositoryImpl
class FakeAuthRepositoryImplFailure implements AuthRepository {
  @override
  Future<AuthResult> authenticate() async {
    // Simulating a failure scenario
    return AuthResult(success: false, message: "Error: Authentication failed");
  }
}
