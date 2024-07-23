// Injection file contain all injection methods feature, and it is called from the main.dart
// Using GetIt

import 'package:get_it/get_it.dart';
import 'package:progresssoft_task/features/app/repository/app_repository.dart';
import 'package:progresssoft_task/features/auth/data/repositories/user_repository_impl.dart';
import 'package:progresssoft_task/features/auth/data/services/firebase_service.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/auth_phone_number.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/create_user.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/sign_in.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/app_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  // Bloc
  sl.registerFactory(
      () => SignInBloc(signInUseCase: sl(), appRepository: sl()));
  sl.registerFactory(
    () => SignUpBloc(
        createUserUseCase: sl(),
        phoneNumberAuthenticationUseCase: sl(),
        verifyOTPUseCase: sl(),
        appRepository: sl()),
  );
  sl.registerFactory(() => AppBloc(appRepository: sl()));

  // UseCases
  sl.registerLazySingleton(() => SignInUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(
      () => PhoneNumberAuthenticationUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(userRepository: sl()));

  // Repository
  sl.registerLazySingleton(() => AppRepository());
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(firebaseService: sl()));
  sl.registerLazySingleton(() => FirebaseService());

  // External

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
