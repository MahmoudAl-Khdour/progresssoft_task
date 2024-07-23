part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final UserInfo user;
  SignInSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class SignInErrorState extends SignInState {
  final String errorMessage;

  SignInErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PasswordVisibleState extends SignInState {}

class PasswordHiddenState extends SignInState {}

class UserExistsInFireStoreState extends SignInState {}

class UserDoesNotExistInFireStoreState extends SignInState {}
