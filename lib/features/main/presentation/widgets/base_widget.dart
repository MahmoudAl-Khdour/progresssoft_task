// base_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/app_bloc.dart';
import 'package:progresssoft_task/features/main/presentation/screens/home_screen.dart';
import 'package:progresssoft_task/features/main/presentation/screens/profile_screen.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          int currentIndex =
              (state is ChangeCurrentIndexState) ? state.index : 1;

          return Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarTheme.color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(0.22),
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                selectedIndex: currentIndex,
                elevation: 27,
                onDestinationSelected: (int index) {
                  BlocProvider.of<AppBloc>(context)
                      .add(ChangeCurrentIndexEvent(index: index));
                },
                backgroundColor: Theme.of(context).bottomAppBarTheme.color,
                indicatorColor: Theme.of(context).primaryColor,
                destinations: [
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.person,
                      color: Colors.grey[200],
                    ),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: 'Profile'.tr,
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      color: Colors.grey[200],
                    ),
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home'.tr,
                  ),
                ],
                surfaceTintColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
            ),
            body: IndexedStack(
              index: currentIndex,
              children: const [
                ProfileScreen(),
                HomeScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
