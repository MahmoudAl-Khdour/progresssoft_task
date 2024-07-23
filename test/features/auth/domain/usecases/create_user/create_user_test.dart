import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/create_user.dart';

import '../auth_phone_number/auth_phone_number_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late CreateUserUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = CreateUserUseCase(userRepository: mockUserRepository);
  });

  const tUserInfo = UserInfo(
    fullName: 'Mahmoud Alkhdour',
    phoneNumber: '+962788314198',
    age: 24,
    gender: 1,
    password: '12345678',
  );

  test('should return [Unit] when the call to the repository is successful',
      () async {
    // Arrange
    when(mockUserRepository.createUser(userInfo: anyNamed('userInfo')))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await useCase.call(userInfo: tUserInfo);

    // Assert
    expect(result, const Right(unit));
    verify(mockUserRepository.createUser(userInfo: tUserInfo));
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'should return [Failure] when the call to the repository is unsuccessful',
      () async {
    // Arrange
    final tFailure = ServerFailure();
    when(mockUserRepository.createUser(userInfo: anyNamed('userInfo')))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase.call(userInfo: tUserInfo);

    // Assert
    expect(result, Left(tFailure));
    verify(mockUserRepository.createUser(userInfo: tUserInfo));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
