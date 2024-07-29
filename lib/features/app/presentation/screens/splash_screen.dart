import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/routes/app_routes.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';
import 'package:progresssoft_task/core/utils/constant/app_images.dart';
import 'package:progresssoft_task/core/utils/constant/app_sizes.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/app_bloc/app_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isLogin = CacheHelper.getData(key: 'isLogin') ?? false;

    context.read<AppBloc>().add(GetValidatorsEvent());
    context.read<AppBloc>().add(GetCountriesEvent());

    Future.delayed(const Duration(seconds: 2), () {
      return Get.offAllNamed(isLogin ? AppRoutes.base : AppRoutes.signIn);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig.init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: AppSizeConfig.screenWidth * 0.9,
            height: AppSizeConfig.screenHeight * 0.2,
            fit: BoxFit.fill,
            image: const AssetImage(
              AppImages.progressSoftLogo,
            ),
          ),
          const SizedBox(
            height: AppDefaults.defaultVerticalSpaceBetweenSmallWidget,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright,
                color: Colors.grey[500],
                size: 15,
              ),
              const SizedBox(
                width: AppDefaults.defaultHorizontalSpaceBetweenSmallWidget,
              ),
              Text(
                'Progress Soft. All Rights Reserved'.tr,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
