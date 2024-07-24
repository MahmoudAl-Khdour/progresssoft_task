import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/features/app/repository/app_repository.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/sign_in.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final AppRepository appRepository;

  SignInBloc({required this.signInUseCase, required this.appRepository})
      : super(PasswordHiddenState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      if (state is PasswordHiddenState) {
        emit(PasswordVisibleState());
      } else {
        emit(PasswordHiddenState());
      }
    });

    on<SignInSubmitEvent>((event, emit) async {
      await _onSignInSubmit(event, emit);
    });
  }

  Future<void> _onSignInSubmit(
    SignInSubmitEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadingState());

    final result = await signInUseCase.call(
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(SignInErrorState(
            failure.message ?? AppMessages.somethingWentWrongMessage));
      },
      (user) {
        CacheHelper.setData(key: 'isLogin', value: true);
        CacheHelper.setData(key: 'userInfo', value: UserInfo.encode(user));
        appRepository.userInfo = user;
        emit(SignInSuccessState(user));
      },
    );
  }
}
