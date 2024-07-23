import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/features/app/repository/app_repository.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/auth_phone_number.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/create_user.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/verify_otp_code.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CreateUserUseCase createUserUseCase;
  final PhoneNumberAuthenticationUseCase phoneNumberAuthenticationUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final AppRepository appRepository;

  SignUpBloc({
    required this.createUserUseCase,
    required this.phoneNumberAuthenticationUseCase,
    required this.verifyOTPUseCase,
    required this.appRepository,
  }) : super(SignUpInitialState()) {
    // For password visibility
    on<TogglePasswordVisibilityEvent>((event, emit) {
      if (state is PasswordHiddenState) {
        emit(PasswordVisibleState());
      } else {
        emit(PasswordHiddenState());
      }
    });
    // For confirm password visibility
    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      if (state is ConfirmPasswordHiddenState) {
        emit(ConfirmPasswordVisibleState());
      } else {
        emit(ConfirmPasswordHiddenState());
      }
    });
    // For gender selection
    on<SelectGenderEvent>((event, emit) {
      emit(GenderSelectedState(event.gender));
    });

    on<SignUpSubmitEvent>((event, emit) async {
      await _onSignUpSubmit(event, emit);
    });

    on<PhoneNumberAuthEvent>((event, emit) async {
      await _onPhoneNumberAuth(event, emit);
    });

    on<VerifyOTPCodeEvent>((event, emit) async {
      await _onVerifyOTPAuth(event, emit);
    });
  }

  Future<void> _onSignUpSubmit(
    SignUpSubmitEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());

    // Prepare user info
    final userInfo = UserInfo(
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
      password: event.password,
      gender: event.gender,
      age: event.age,
    );

    // Call CreateUserUseCase
    final result = await createUserUseCase.call(userInfo: userInfo);

    result.fold(
      (failure) {
        emit(SignUpErrorState('')); // Handle failure
      },
      (_) {
        CacheHelper.setData(key: 'isLogin', value: true);
        CacheHelper.setData(key: 'userInfo', value: UserInfo.encode(userInfo));
        appRepository.userInfo = userInfo;
        emit(SignUpSuccessState()); // Handle success
      },
    );
  }

  Future<void> _onPhoneNumberAuth(
    PhoneNumberAuthEvent event,
    Emitter<SignUpState> emit,
  ) async {
    // Call CreateUserUseCase
    final result = await phoneNumberAuthenticationUseCase.call(
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) async {
        emit(PhoneAuthErrorState('')); // Handle failure
      },
      (_) async {
        emit(PhoneAuthSuccessState()); // Handle failure
      },
    );
  }

  Future<void> _onVerifyOTPAuth(
    VerifyOTPCodeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    // Call verifyOTPUseCase
    final result = await verifyOTPUseCase.call(
      otpCode: event.otpCode,
    );

    result.fold(
      (failure) {
        emit(VerifyOTPErrorState('')); // Handle failure
      },
      (_) {
        emit(VerifyOTPSuccessState()); // Handle success
        // Navigate to OTP verification page
      },
    );
  }
}
