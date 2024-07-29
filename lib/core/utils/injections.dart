// Injection file contain all injection methods feature, and it is called from the main.dart
// Using GetIt

import 'package:get_it/get_it.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/app/data/repositories/config_repository_impl.dart';
import 'package:progresssoft_task/features/app/data/services/config_service.dart';
import 'package:progresssoft_task/features/app/domian/repositories/config_repository.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_countries.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_validators.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:progresssoft_task/features/auth/data/repositories/user_repository_impl.dart';
import 'package:progresssoft_task/features/auth/data/services/firebase_service.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/auth_phone_number.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/create_user.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/sign_in.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:progresssoft_task/features/main/data/data_sources/remote_data_sources.dart';
import 'package:progresssoft_task/features/main/data/repositories/post_repository_impl.dart';
import 'package:progresssoft_task/features/main/domain/repositories/post_repository.dart';
import 'package:progresssoft_task/features/main/domain/usecases/get_all_posts.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  // Bloc
  sl.registerFactory(() => AppBloc(
        getAllValidatorsUseCase: sl(),
        getAllCountriesUseCase: sl(),
        appRepository: sl(),
      ));
  sl.registerFactory(
      () => SignInBloc(signInUseCase: sl(), appRepository: sl()));
  sl.registerFactory(
    () => SignUpBloc(
        createUserUseCase: sl(),
        phoneNumberAuthenticationUseCase: sl(),
        verifyOTPUseCase: sl(),
        appRepository: sl()),
  );
  sl.registerFactory(() => MainBloc(
        appRepository: sl(),
        getAllPostsUseCase: sl(),
      ));

  sl.registerFactory(() => BaseBloc());

  // UseCases
  sl.registerLazySingleton(() => SignInUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(
      () => PhoneNumberAuthenticationUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(userRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllValidatorsUseCase(configRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllCountriesUseCase(configRepository: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));

  // Repository
  sl.registerLazySingleton(() => AppRepository());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(firebaseService: sl()));
  sl.registerLazySingleton<ConfigRepository>(
      () => ConfigRepositoryImpl(firebaseConfigService: sl()));
  sl.registerLazySingleton<PostsRepository>(
      () => PostRepositoryImpl(remoteDataSources: sl()));

  sl.registerLazySingleton(() => FirebaseService());
  sl.registerLazySingleton(() => FirebaseConfigService());
  sl.registerLazySingleton(() => RemoteDataSources());

  // External

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
