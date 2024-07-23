import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/auth_phone_number.dart';

import 'auth_phone_number_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late PhoneNumberAuthenticationUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase =
        PhoneNumberAuthenticationUseCase(userRepository: mockUserRepository);
  });

  const tPhoneNumber = '+962788314198';

  test('should return [Unit] when the call to the repository is successful',
      () async {
    // Arrange
    when(mockUserRepository.phoneNumberAuthentication(
            phoneNumber: anyNamed('phoneNumber')))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await useCase.call(phoneNumber: tPhoneNumber);

    // Assert
    expect(result, const Right(unit));
    verify(mockUserRepository.phoneNumberAuthentication(
        phoneNumber: tPhoneNumber));
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'should return [Failure] when the call to the repository is unsuccessful',
      () async {
    // Arrange
    final tFailure = ServerFailure();
    when(mockUserRepository.phoneNumberAuthentication(
            phoneNumber: anyNamed('phoneNumber')))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase.call(phoneNumber: tPhoneNumber);

    // Assert
    expect(result, Left(tFailure));
    verify(mockUserRepository.phoneNumberAuthentication(
        phoneNumber: tPhoneNumber));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
