import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/verify_otp_code.dart';

import 'verify_otp_code_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late VerifyOTPUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = VerifyOTPUseCase(userRepository: mockUserRepository);
  });

  const tOtpCode = '123456';

  test('should return [Unit] when the call to the repository is successful',
      () async {
    // Arrange
    when(mockUserRepository.verifyOTP(
      otpCode: anyNamed('otpCode'),
    )).thenAnswer((_) async => const Right(unit));

    // Act
    final result = await useCase.call(
      otpCode: tOtpCode,
    );

    // Assert
    expect(result, const Right(unit));
    verify(mockUserRepository.verifyOTP(
      otpCode: tOtpCode,
    ));
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'should return [Failure] when the call to the repository is unsuccessful',
      () async {
    // Arrange
    final tFailure = ServerFailure();
    when(mockUserRepository.verifyOTP(
      otpCode: anyNamed('otpCode'),
    )).thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase.call(
      otpCode: tOtpCode,
    );

    // Assert
    expect(result, Left(tFailure));
    verify(mockUserRepository.verifyOTP(
      otpCode: tOtpCode,
    ));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
