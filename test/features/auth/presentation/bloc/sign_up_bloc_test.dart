import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';

import '../../helper/test_main_helper.mocks.dart';

void main() {
  late SignUpBloc signUpBloc;
  late MockCreateUserUseCase mockCreateUserUseCase;
  late MockPhoneNumberAuthenticationUseCase
      mockPhoneNumberAuthenticationUseCase;
  late MockVerifyOTPUseCase mockVerifyOTPUseCase;
  late MockAppRepository mockAppRepository;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockCreateUserUseCase = MockCreateUserUseCase();
    mockPhoneNumberAuthenticationUseCase =
        MockPhoneNumberAuthenticationUseCase();
    mockVerifyOTPUseCase = MockVerifyOTPUseCase();
    mockAppRepository = MockAppRepository();
    mockSharedPreferences = MockSharedPreferences();

    CacheHelper.sharedPreferences = mockSharedPreferences;

    signUpBloc = SignUpBloc(
      createUserUseCase: mockCreateUserUseCase,
      phoneNumberAuthenticationUseCase: mockPhoneNumberAuthenticationUseCase,
      verifyOTPUseCase: mockVerifyOTPUseCase,
      appRepository: mockAppRepository,
    );
  });

  group('SignUpBloc', () {
    const tFullName = 'Mahmoud Alkhdour';
    const tPhoneNumber = '+962788314198';
    const tPassword = '12345678';
    const tGender = 1;
    const tAge = 24;
    const tOTPCode = '123456';

    const tUserInfo = UserInfo(
      fullName: tFullName,
      phoneNumber: tPhoneNumber,
      password: tPassword,
      gender: tGender,
      age: tAge,
    );

    test('initial state is SignUpInitialState', () {
      expect(signUpBloc.state, equals(SignUpInitialState()));
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits [PasswordVisibleState] when TogglePasswordVisibilityEvent is added and current state is PasswordHiddenState',
      build: () {
        signUpBloc.emit(PasswordHiddenState());
        return signUpBloc;
      },
      act: (bloc) => bloc.add(TogglePasswordVisibilityEvent()),
      expect: () => [PasswordVisibleState()],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [PasswordHiddenState] when TogglePasswordVisibilityEvent is added and current state is PasswordVisibleState',
      build: () {
        signUpBloc.emit(PasswordVisibleState());
        return signUpBloc;
      },
      act: (bloc) => bloc.add(TogglePasswordVisibilityEvent()),
      expect: () => [PasswordHiddenState()],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [ConfirmPasswordVisibleState] when ToggleConfirmPasswordVisibilityEvent is added and current state is ConfirmPasswordHiddenState',
      build: () {
        signUpBloc.emit(ConfirmPasswordHiddenState());
        return signUpBloc;
      },
      act: (bloc) => bloc.add(ToggleConfirmPasswordVisibilityEvent()),
      expect: () => [ConfirmPasswordVisibleState()],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [ConfirmPasswordHiddenState] when ToggleConfirmPasswordVisibilityEvent is added and current state is ConfirmPasswordVisibleState',
      build: () {
        signUpBloc.emit(ConfirmPasswordVisibleState());
        return signUpBloc;
      },
      act: (bloc) => bloc.add(ToggleConfirmPasswordVisibilityEvent()),
      expect: () => [ConfirmPasswordHiddenState()],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [GenderSelectedState] when SelectGenderEvent is added',
      build: () => signUpBloc,
      act: (bloc) => bloc.add(SelectGenderEvent(tGender)),
      expect: () => [GenderSelectedState(tGender)],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpLoadingState, SignUpSuccessState] when SignUpSubmitEvent is successful',
      build: () {
        when(mockCreateUserUseCase.call(userInfo: tUserInfo))
            .thenAnswer((_) async => const Right(unit));
        when(mockSharedPreferences.setBool('isLogin', true))
            .thenAnswer((_) async => true);
        when(mockSharedPreferences.setString(
                'userInfo', UserInfo.encode(tUserInfo)))
            .thenAnswer((_) async => true);
        return signUpBloc;
      },
      act: (bloc) => bloc.add(SignUpSubmitEvent(
        fullName: tFullName,
        phoneNumber: tPhoneNumber,
        password: tPassword,
        gender: tGender,
        age: tAge,
      )),
      expect: () => [
        SignUpLoadingState(),
        SignUpSuccessState(),
      ],
      verify: (_) {
        verify(mockCreateUserUseCase.call(userInfo: tUserInfo)).called(1);
        verify(mockSharedPreferences.setBool('isLogin', true)).called(1);
        verify(mockSharedPreferences.setString(
                'userInfo', UserInfo.encode(tUserInfo)))
            .called(1);
        verify(mockAppRepository.userInfo = tUserInfo).called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpLoadingState, SignUpErrorState] when SignUpSubmitEvent fails',
      build: () {
        when(mockCreateUserUseCase.call(userInfo: tUserInfo)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Sign up failed')));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(SignUpSubmitEvent(
        fullName: tFullName,
        phoneNumber: tPhoneNumber,
        password: tPassword,
        gender: tGender,
        age: tAge,
      )),
      expect: () => [
        SignUpLoadingState(),
        SignUpErrorState('Sign up failed'),
      ],
      verify: (_) {
        verify(mockCreateUserUseCase.call(userInfo: tUserInfo)).called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [PhoneAuthLoadingState, PhoneAuthSuccessState] when PhoneNumberAuthEvent is successful',
      build: () {
        when(mockPhoneNumberAuthenticationUseCase.call(
                phoneNumber: tPhoneNumber))
            .thenAnswer((_) async => const Right(unit));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(PhoneNumberAuthEvent(phoneNumber: tPhoneNumber)),
      expect: () => [
        PhoneAuthLoadingState(),
        PhoneAuthSuccessState(),
      ],
      verify: (_) {
        verify(mockPhoneNumberAuthenticationUseCase.call(
                phoneNumber: tPhoneNumber))
            .called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [PhoneAuthLoadingState, PhoneAuthErrorState] when PhoneNumberAuthEvent fails',
      build: () {
        when(mockPhoneNumberAuthenticationUseCase.call(
                phoneNumber: tPhoneNumber))
            .thenAnswer((_) async =>
                const Left(ServerFailure(message: 'Phone auth failed')));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(PhoneNumberAuthEvent(phoneNumber: tPhoneNumber)),
      expect: () => [
        PhoneAuthLoadingState(),
        PhoneAuthErrorState('Phone auth failed'),
      ],
      verify: (_) {
        verify(mockPhoneNumberAuthenticationUseCase.call(
                phoneNumber: tPhoneNumber))
            .called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [VerifyOTPLoadingState, VerifyOTPSuccessState] when VerifyOTPCodeEvent is successful',
      build: () {
        when(mockVerifyOTPUseCase.call(otpCode: tOTPCode))
            .thenAnswer((_) async => const Right(unit));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(VerifyOTPCodeEvent(otpCode: tOTPCode)),
      expect: () => [
        VerifyOTPLoadingState(),
        VerifyOTPSuccessState(),
      ],
      verify: (_) {
        verify(mockVerifyOTPUseCase.call(otpCode: tOTPCode)).called(1);
      },
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [VerifyOTPLoadingState, VerifyOTPErrorState] when VerifyOTPCodeEvent fails',
      build: () {
        when(mockVerifyOTPUseCase.call(otpCode: tOTPCode)).thenAnswer(
            (_) async =>
                const Left(ServerFailure(message: 'OTP verification failed')));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(VerifyOTPCodeEvent(otpCode: tOTPCode)),
      expect: () => [
        VerifyOTPLoadingState(),
        VerifyOTPErrorState('OTP verification failed'),
      ],
      verify: (_) {
        verify(mockVerifyOTPUseCase.call(otpCode: tOTPCode)).called(1);
      },
    );
  });
}
