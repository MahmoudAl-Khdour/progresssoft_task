import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';

import '../../helper/test_main_helper.mocks.dart';

void main() {
  late SignInBloc signInBloc;
  late MockAppRepository mockAppRepository;
  late MockSignInUseCase mockSignInUseCase;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockAppRepository = MockAppRepository();
    mockSignInUseCase = MockSignInUseCase();
    mockSharedPreferences = MockSharedPreferences();

    // Initialize the CacheHelper with the mock
    CacheHelper.sharedPreferences = mockSharedPreferences;

    signInBloc = SignInBloc(
      signInUseCase: mockSignInUseCase,
      appRepository: mockAppRepository,
    );
  });

  group('SignInBloc', () {
    const tPhoneNumber = '123456789';
    const tPassword = 'password';
    const tUserInfo = UserInfo(
      fullName: 'Test User',
      phoneNumber: '123456789',
      password: 'password',
      gender: 1,
      age: 30,
    );

    test('initial state is PasswordHiddenState', () {
      expect(signInBloc.state, equals(PasswordHiddenState()));
    });

    blocTest<SignInBloc, SignInState>(
      'emits [PasswordVisibleState] when TogglePasswordVisibilityEvent is added and current state is PasswordHiddenState',
      build: () => signInBloc,
      act: (bloc) => bloc.add(TogglePasswordVisibilityEvent()),
      expect: () => [PasswordVisibleState()],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [PasswordHiddenState] when TogglePasswordVisibilityEvent is added and current state is PasswordVisibleState',
      build: () => signInBloc..emit(PasswordVisibleState()),
      act: (bloc) => bloc.add(TogglePasswordVisibilityEvent()),
      expect: () => [PasswordHiddenState()],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [CountryCodeSelectedState] when SelectCountryCodeEvent is added',
      build: () => signInBloc,
      act: (bloc) => bloc.add(SelectCountryCodeEvent('US')),
      expect: () => [CountryCodeSelectedState('US')],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [SignInLoadingState, SignInSuccessState] when SignInSubmitEvent is successful',
      build: () {
        when(mockSignInUseCase.call(
                phoneNumber: tPhoneNumber, password: tPassword))
            .thenAnswer((_) async => const Right(tUserInfo));
        when(mockSharedPreferences.setBool('isLogin', true))
            .thenAnswer((_) async => true);
        when(mockSharedPreferences.setString(
                'userInfo', UserInfo.encode(tUserInfo)))
            .thenAnswer((_) async => true);
        return signInBloc;
      },
      act: (bloc) => bloc.add(
          SignInSubmitEvent(phoneNumber: tPhoneNumber, password: tPassword)),
      expect: () => [
        SignInLoadingState(),
        SignInSuccessState(tUserInfo),
      ],
      verify: (_) {
        verify(mockSignInUseCase.call(
                phoneNumber: tPhoneNumber, password: tPassword))
            .called(1);
        verify(mockSharedPreferences.setBool('isLogin', true)).called(1);
        verify(mockSharedPreferences.setString(
                'userInfo', UserInfo.encode(tUserInfo)))
            .called(1);
        verify(mockAppRepository.userInfo = tUserInfo).called(1);
      },
    );

    blocTest<SignInBloc, SignInState>(
      'emits [SignInLoadingState, SignInErrorState] when SignInSubmitEvent fails',
      build: () {
        when(mockSignInUseCase.call(
                phoneNumber: tPhoneNumber, password: tPassword))
            .thenAnswer((_) async =>
                const Left(ServerFailure(message: 'Invalid credentials')));
        return signInBloc;
      },
      act: (bloc) => bloc.add(
          SignInSubmitEvent(phoneNumber: tPhoneNumber, password: tPassword)),
      expect: () => [
        SignInLoadingState(),
        SignInErrorState('Invalid credentials'),
      ],
      verify: (_) {
        verify(mockSignInUseCase.call(
                phoneNumber: tPhoneNumber, password: tPassword))
            .called(1);
      },
    );
  });
}
