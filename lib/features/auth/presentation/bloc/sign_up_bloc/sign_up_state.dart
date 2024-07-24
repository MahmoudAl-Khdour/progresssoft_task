part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMessage;

  SignUpErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PhoneAuthLoadingState extends SignUpState {}

class PhoneAuthSuccessState extends SignUpState {}

class PhoneAuthErrorState extends SignUpState {
  final String errorMessage;

  PhoneAuthErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class VerifyOTPLoadingState extends SignUpState {}

class VerifyOTPSuccessState extends SignUpState {}

class VerifyOTPErrorState extends SignUpState {
  final String errorMessage;

  VerifyOTPErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PasswordVisibleState extends SignUpState {}

class PasswordHiddenState extends SignUpState {}

class ConfirmPasswordVisibleState extends SignUpState {}

class ConfirmPasswordHiddenState extends SignUpState {}

class GenderSelectedState extends SignUpState {
  final int selectedGender;

  GenderSelectedState(this.selectedGender);

  @override
  List<Object?> get props => [selectedGender];
}
