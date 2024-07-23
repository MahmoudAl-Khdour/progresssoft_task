import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/utils/bloc_observer.dart';
import 'package:progresssoft_task/features/app/presentation/shared/widgets/app_widget.dart';

import 'core/utils/firebase_options.dart';
import 'core/utils/injections.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  await di.initInjections();

  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String language = await CacheHelper.getData(key: 'lang') ?? 'en';
  String theme = await CacheHelper.getData(key: 'theme') ?? 'light';

  runApp(
    AppWidget(
      theme: theme,
      language: language,
    ),
  );
}
