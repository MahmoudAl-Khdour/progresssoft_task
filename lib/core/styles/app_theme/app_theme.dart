import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';

// This class depending on primary and secondary colors
class AppTheme {
  // To prevent create object from this class theme
  AppTheme._();

  // Light theme for light theme for this app
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    secondaryHeaderColor: AppColors.appWhiteColor,
    primarySwatch: AppColors.kPrimaryColor,
    primaryColor: AppColors.lightDefaultColor,
    cardColor: Colors.grey,
    fontFamily: 'Almarai',
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.appLightColor,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.lightDefaultColor,
      shadowColor: AppColors.appLightColor!.withOpacity(0.2),
      scrimColor: AppColors.appLightColor!.withOpacity(0.8),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(
        color: AppColors.appLightColor,
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: AppColors.lightDefaultColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.lightDefaultColor,
    ),
    scaffoldBackgroundColor: AppColors.appLightColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: AppColors.appBlackColor,
      ),
      backgroundColor: AppColors.appLightColor,
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarContrastEnforced: true,
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.appLightColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.lightDefaultColor,
        systemStatusBarContrastEnforced: true,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: AppColors.appBlackColor,
        size: 32,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: const TextStyle(
        color: AppColors.lightDefaultColor,
        fontSize: 14,
      ),
      headlineLarge: const TextStyle(
        color: AppColors.lightDefaultColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      headlineMedium: const TextStyle(
        color: AppColors.appBlackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineSmall: const TextStyle(
        color: AppColors.lightDefaultColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyLarge: const TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 18,
      ),
      bodyMedium: const TextStyle(
        color: AppColors.lightDefaultColor,
        fontSize: 16,
      ),
      bodySmall: const TextStyle(
        color: AppColors.lightDefaultColor,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: AppColors.lightDefaultColor.withOpacity(0.4),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        color: AppColors.lightDefaultColor.withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        color: AppColors.lightDefaultColor.withOpacity(0.4),
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColors.lightDefaultColor,
        size: 25,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.appBlackColor,
        size: 20,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.lightDefaultColor,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 11,
      ),
      backgroundColor: AppColors.appWhiteColor,
      selectedItemColor: AppColors.lightDefaultColor,
      unselectedItemColor: AppColors.appBlackColor,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkNavBarColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      surfaceTintColor: AppColors.appLightColor,
      labelTextStyle: MaterialStateTextStyle.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: AppColors.lightDefaultColor,
              fontSize: 13,
            ); // Color when the button is pressed
          }
          return const TextStyle(
            color: AppColors.appBlackColor,
            fontSize: 11,
          );
        },
      ),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelStyle: TextStyle(
        color: AppColors.lightDefaultColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        color: AppColors.appLightColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      tabAlignment: TabAlignment.fill,
      unselectedLabelColor: AppColors.lightDefaultColor,
      labelColor: AppColors.appLightColor,
      dividerColor: AppColors.appWhiteColor,
      indicatorColor: AppColors.appLightColor,
      indicator: BoxDecoration(
        color: AppColors.lightDefaultColor,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.defaultLeftRadius),
        ),
      ),
    ),
    shadowColor: AppColors.appLightColor,
  );

  // Dark theme for light theme for this app
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    cardColor: AppColors.darkDefaultColor,
    primarySwatch: AppColors.kPrimaryColor,
    primaryColor: AppColors.darkDefaultColor,
    fontFamily: 'Almarai',
    secondaryHeaderColor: AppColors.darkNavBarColor,
    primaryIconTheme: const IconThemeData(
      color: AppColors.darkDefaultColor,
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.darkNavBarColor),
    dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: AppColors.darkNavBarColor)),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.appBlackColor,
      shadowColor: AppColors.darkNavBarColor.withOpacity(0.5),
      scrimColor: AppColors.darkNavBarColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkDefaultColor,
    ),
    scaffoldBackgroundColor: AppColors.appBlackColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: AppColors.appLightColor,
      ),
      backgroundColor: AppColors.darkNavBarColor,
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: AppColors.appBlackColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.darkNavBarColor,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: AppColors.darkNavBarColor,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.appLightColor,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: AppColors.appLightColor,
        size: 32,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: const TextStyle(
        color: AppColors.darkDefaultColor,
        fontSize: 14,
      ),
      headlineLarge: const TextStyle(
        color: AppColors.appLightColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      headlineMedium: const TextStyle(
        color: AppColors.appLightColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineSmall: const TextStyle(
        color: AppColors.darkDefaultColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyLarge: const TextStyle(
        color: AppColors.appWhiteColor,
        fontSize: 18,
      ),
      bodyMedium: const TextStyle(
        color: AppColors.darkDefaultColor,
        fontSize: 16,
      ),
      bodySmall: const TextStyle(
        color: AppColors.darkDefaultColor,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: AppColors.darkDefaultColor.withOpacity(0.4),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        color: AppColors.darkDefaultColor.withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        color: AppColors.darkDefaultColor.withOpacity(0.4),
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColors.darkDefaultColor,
        size: 25,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.appLightColor,
        size: 20,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.darkDefaultColor,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.appLightColor,
        fontSize: 11,
      ),
      backgroundColor: AppColors.darkNavBarColor,
      selectedItemColor: AppColors.darkDefaultColor,
      unselectedItemColor: AppColors.appLightColor,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkNavBarColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      surfaceTintColor: AppColors.appLightColor,
      labelTextStyle: MaterialStateTextStyle.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: AppColors.darkDefaultColor,
              fontSize: 13,
            ); // Color when the button is pressed
          }
          return const TextStyle(
            color: AppColors.appLightColor,
            fontSize: 11,
          );
        },
      ),
    ),
    shadowColor: AppColors.darkNavBarColor,
    tabBarTheme: const TabBarTheme(
      unselectedLabelStyle: TextStyle(
        color: AppColors.darkDefaultColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      tabAlignment: TabAlignment.fill,
      unselectedLabelColor: AppColors.darkDefaultColor,
      labelColor: AppColors.appBlackColor,
      dividerColor: AppColors.darkNavBarColor,
      indicatorColor: AppColors.appBlackColor,
      indicator: BoxDecoration(
        color: AppColors.lightDefaultColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDefaults.defaultLeftRadius,
          ),
        ),
      ),
    ),
  );
}
