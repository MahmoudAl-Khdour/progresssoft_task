import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
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
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state is PasswordHiddenState
          ? PasswordVisibleState()
          : PasswordHiddenState());
    });

    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      emit(state is ConfirmPasswordHiddenState
          ? ConfirmPasswordVisibleState()
          : ConfirmPasswordHiddenState());
    });

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

    final userInfo = UserInfo(
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
      password: event.password,
      gender: event.gender,
      age: event.age,
    );

    final result = await createUserUseCase.call(userInfo: userInfo);

    result.fold(
      (failure) {
        emit(SignUpErrorState(
            failure.message ?? AppMessages.somethingWentWrongMessage));
      },
      (_) {
        CacheHelper.setData(key: 'isLogin', value: true);
        CacheHelper.setData(key: 'userInfo', value: UserInfo.encode(userInfo));
        appRepository.userInfo = userInfo;
        emit(SignUpSuccessState());
      },
    );
  }

  Future<void> _onPhoneNumberAuth(
    PhoneNumberAuthEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(PhoneAuthLoadingState());

    final result = await phoneNumberAuthenticationUseCase.call(
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) async {
        emit(PhoneAuthErrorState(
            failure.message ?? AppMessages.somethingWentWrongMessage));
      },
      (_) async {
        emit(PhoneAuthSuccessState());
      },
    );
  }

  Future<void> _onVerifyOTPAuth(
    VerifyOTPCodeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(VerifyOTPLoadingState());

    final result = await verifyOTPUseCase.call(
      otpCode: event.otpCode,
    );

    result.fold(
      (failure) {
        emit(VerifyOTPErrorState(
            failure.message ?? AppMessages.somethingWentWrongMessage));
      },
      (_) {
        emit(VerifyOTPSuccessState());
      },
    );
  }
}
