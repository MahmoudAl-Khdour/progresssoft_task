part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpSubmitEvent extends SignUpEvent {
  final String phoneNumber;
  final String password;
  final String fullName;
  final int gender;
  final int age;

  SignUpSubmitEvent({
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.gender,
    required this.age,
  });

  @override
  List<Object> get props => [phoneNumber, password, fullName, gender, age];
}

class PhoneNumberAuthEvent extends SignUpEvent {
  final String phoneNumber;

  PhoneNumberAuthEvent({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOTPCodeEvent extends SignUpEvent {
  final String otpCode;

  VerifyOTPCodeEvent({
    required this.otpCode,
  });

  @override
  List<Object> get props => [otpCode];
}

class TogglePasswordVisibilityEvent extends SignUpEvent {}

class ToggleConfirmPasswordVisibilityEvent extends SignUpEvent {}

class SelectGenderEvent extends SignUpEvent {
  final int gender;

  SelectGenderEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class SelectCountryCodeEvent extends SignUpEvent {
  final String countryCode;

  SelectCountryCodeEvent(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}
