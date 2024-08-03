import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_validators.dart';

import '../../helper/app_helper.mocks.dart';

void main() {
  late MockConfigRepository mockConfigRepository;
  late GetAllValidatorsUseCase useCase;

  setUp(() {
    mockConfigRepository = MockConfigRepository();
    useCase = GetAllValidatorsUseCase(configRepository: mockConfigRepository);
  });

  test(
      'Should return a Validators object when the repository call is successful',
      () async {
    // arrange
    const validators = Validators(
      password: "^.{6,}",
      fullName: "^[A-Za-z]+(?: [A-Za-z]+)*",
      birthDate: "^(19|20)d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]d|3[01])",
      phone: {"+962": "^+962d{9}"},
    ); // Create a valid Validators object
    when(mockConfigRepository.getAllValidators())
        .thenAnswer((_) async => const Right(validators));

    // act
    final result = await useCase.call();

    // assert
    expect(result, const Right(validators));
    verify(mockConfigRepository.getAllValidators());
    verifyNoMoreInteractions(mockConfigRepository);
  });

  test('Should return a failure when the repository call fails', () async {
    // arrange
    const failure = ServerFailure(message: 'Error message');
    when(mockConfigRepository.getAllValidators())
        .thenAnswer((_) async => const Left(failure));

    // act
    final result = await useCase.call();

    // assert
    expect(result, const Left(failure));
    verify(mockConfigRepository.getAllValidators());
    verifyNoMoreInteractions(mockConfigRepository);
  });
}
