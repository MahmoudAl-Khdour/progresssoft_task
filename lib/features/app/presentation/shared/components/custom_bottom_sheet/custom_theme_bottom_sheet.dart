import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/utils/constant/app_sizes.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/theme_bloc/theme_state.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizeConfig.init(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            width: AppSizeConfig.screenWidth,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    ThemeBloc.get(context).add(ThemeEvent.toggleLight);
                    Get.back();
                  },
                  leading: Icon(
                    Icons.light_mode_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  title: Text(
                    'Light Theme'.tr,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              fontSize: 16,
                            ),
                  ),
                  trailing:
                      ThemeBloc.get(context).state.themeMode == ThemeMode.light
                          ? Icon(
                              Icons.check_box,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                ),
                ListTile(
                  onTap: () {
                    ThemeBloc.get(context).add(ThemeEvent.toggleDark);
                    Get.back();
                  },
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  title: Text(
                    'Dark Theme'.tr,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              fontSize: 16,
                            ),
                  ),
                  trailing:
                      ThemeBloc.get(context).state.themeMode == ThemeMode.dark
                          ? Icon(
                              Icons.check_box,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                ),
                ListTile(
                  onTap: () {
                    ThemeBloc.get(context).add(ThemeEvent.toggleSystem);
                    Get.back();
                  },
                  trailing:
                      ThemeBloc.get(context).state.themeMode == ThemeMode.system
                          ? Icon(
                              Icons.check_box,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                  leading: Icon(
                    Icons.settings_system_daydream_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  title: Text(
                    'System Default'.tr,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              fontSize: 16,
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
