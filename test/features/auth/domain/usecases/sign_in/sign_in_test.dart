import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/sign_in.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late SignInUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = SignInUseCase(userRepository: mockUserRepository);
  });

  const tPhoneNumber = '+962788314198';
  const tPassword = '12345678';
  const tUserInfo = UserInfo(
    fullName: 'Mahmoud Alkhdour',
    phoneNumber: tPhoneNumber,
    age: 24,
    gender: 1,
    password: tPassword,
  );

  test('should return [UserInfo] when the call to the repository is successful',
      () async {
    // Arrange
    when(mockUserRepository.signIn(
      phoneNumber: anyNamed('phoneNumber'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => const Right(tUserInfo));

    // Act
    final result = await useCase.call(
      phoneNumber: tPhoneNumber,
      password: tPassword,
    );

    // Assert
    expect(result, const Right(tUserInfo));
    verify(mockUserRepository.signIn(
      phoneNumber: tPhoneNumber,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'should return [Failure] when the call to the repository is unsuccessful',
      () async {
    // Arrange
    const tFailure = ServerFailure();
    when(mockUserRepository.signIn(
      phoneNumber: anyNamed('phoneNumber'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase.call(
      phoneNumber: tPhoneNumber,
      password: tPassword,
    );

    // Assert
    expect(result, const Left(tFailure));
    verify(mockUserRepository.signIn(
      phoneNumber: tPhoneNumber,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
