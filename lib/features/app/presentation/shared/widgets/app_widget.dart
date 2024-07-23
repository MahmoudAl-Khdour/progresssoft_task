import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/routes/app_routes.dart';
import 'package:progresssoft_task/core/styles/app_theme/app_theme.dart';
import 'package:progresssoft_task/core/translations/app_translation.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/injections.dart' as di;
import 'package:progresssoft_task/features/app/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/theme_bloc/theme_state.dart';
import 'package:progresssoft_task/features/app/repository/app_repository.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/app_bloc.dart';

class AppWidget extends StatefulWidget {
  final String language;
  final String theme;

  const AppWidget({
    super.key,
    required this.language,
    required this.theme,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.appLightColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return RepositoryProvider(
      create: (context) => AppRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(
              appTheme: widget.theme,
              context: context,
            ),
          ),
          BlocProvider(create: (_) => di.sl<SignInBloc>()),
          BlocProvider(create: (_) => di.sl<SignUpBloc>()),
          BlocProvider(create: (_) => di.sl<AppBloc>()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return GetMaterialApp(
              title: 'ProgressSoft'.tr,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              locale: Locale(widget.language),
              fallbackLocale: const Locale('en'),
              translations: AppTranslation(),
              initialRoute: AppRoutes.splash,
              getPages: AppRoutes.getPages,
            );
          },
        ),
      ),
    );
  }
}
