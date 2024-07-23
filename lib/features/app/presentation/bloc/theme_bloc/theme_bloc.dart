import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/theme_bloc/theme_state.dart';

enum ThemeEvent {
  toggleDark,
  toggleLight,
  toggleSystem,
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static ThemeBloc get(context) => BlocProvider.of(context);
  String? appTheme;
  BuildContext context;

  ThemeBloc({
    required this.appTheme,
    required this.context,
  }) : super(ThemeState(
          appTheme: appTheme,
          themeMode: ThemeMode.system,
        )) {
    on<ThemeEvent>((event, emit) async {
      switch (event) {
        case ThemeEvent.toggleLight:
          CacheHelper.setData(key: 'theme', value: 'light');

          emit(ThemeState(appTheme: 'light', themeMode: ThemeMode.light));
          changeAppStatus(state: state, context: context);

        case ThemeEvent.toggleDark:
          CacheHelper.setData(key: 'theme', value: 'dark');
          emit(ThemeState(
            appTheme: 'dark',
            themeMode: ThemeMode.dark,
          ));
          changeAppStatus(state: state, context: context);
          break;

        case ThemeEvent.toggleSystem:
          CacheHelper.setData(key: 'theme', value: 'system');
          emit(ThemeState(
            appTheme: 'system',
            themeMode: ThemeMode.system,
          ));
          changeAppStatus(state: state, context: context);
          break;
      }
    });
  }

  changeAppStatus({
    required ThemeState state,
    required BuildContext context,
  }) {
    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);

    SystemChrome.setSystemUIOverlayStyle(state.themeMode == ThemeMode.light
        ? SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.appLightColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          )
        : state.themeMode == ThemeMode.dark
            ? SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarColor: AppColors.appBlackColor,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: AppColors.appBlackColor,
              )
            : platformBrightness == Brightness.light
                ? SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarColor: AppColors.appLightColor,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarIconBrightness: Brightness.dark,
                  )
                : SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarColor: AppColors.appBlackColor,
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: AppColors.appBlackColor,
                  ));
  }
}
