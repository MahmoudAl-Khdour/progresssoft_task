import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/routes/app_routes.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';
import 'package:progresssoft_task/core/utils/constant/app_images.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_bottom_sheet/custom_langauge_bottom_sheet.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_bottom_sheet/custom_theme_bottom_sheet.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/app_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(
            top: AppDefaults.defaultTopPadding,
            right: AppDefaults.defaultRightPadding,
            left: AppDefaults.defaultLeftPadding,
          ),
          children: [
            BlocProvider.of<AppBloc>(context).appRepository.userInfo != null
                ? Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.profilePlaceHolder),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height:
                            AppDefaults.defaultVerticalSpaceBetweenBigWidget *
                                2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: AppDefaults
                                        .defaultHorizontalSpaceBetweenSmallWidget,
                                  ),
                                  Text(
                                    'Full Name'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                BlocProvider.of<AppBloc>(context)
                                    .appRepository
                                    .userInfo!
                                    .fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: AppDefaults
                                        .defaultHorizontalSpaceBetweenSmallWidget,
                                  ),
                                  Text(
                                    'Phone Number'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                '${BlocProvider.of<AppBloc>(context).countryCode}${BlocProvider.of<AppBloc>(context).appRepository.userInfo!.phoneNumber}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.transgender,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: AppDefaults
                                        .defaultHorizontalSpaceBetweenSmallWidget,
                                  ),
                                  Text(
                                    'Gender'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                BlocProvider.of<AppBloc>(context)
                                            .appRepository
                                            .userInfo!
                                            .gender ==
                                        1
                                    ? 'Male'.tr
                                    : 'Female'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.numbers,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: AppDefaults
                                        .defaultHorizontalSpaceBetweenSmallWidget,
                                  ),
                                  Text(
                                    'Age'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                BlocProvider.of<AppBloc>(context)
                                    .appRepository
                                    .userInfo!
                                    .age
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppDefaults
                                .defaultVerticalSpaceBetweenSmallWidget,
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: AppDefaults.defaultVerticalSpaceBetweenWidget,
            ),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              indent: 1,
              endIndent: 1,
            ),
            const SizedBox(
              height: AppDefaults.defaultVerticalSpaceBetweenWidget,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDefaults.defaultRightRadius + 5),
                  ),
                  onTap: () {
                    _chooseLanguage(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          width: 22,
                          height: 22,
                          AppImages.changeLanguage,
                          fit: BoxFit.fill,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Change Language'.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDefaults.defaultRightRadius + 5),
                  ),
                  onTap: () {
                    _chooseTheme(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          width: 22,
                          height: 22,
                          AppImages.themeMode,
                          fit: BoxFit.fill,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Theme Mode'.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  indent: 1,
                  endIndent: 1,
                ),
                const SizedBox(
                  height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDefaults.defaultRightRadius + 5),
                  ),
                  onTap: () {
                    CacheHelper.clear();
                    Get.offAllNamed(AppRoutes.signIn);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Sign Out'.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppDefaults.defaultVerticalSpaceBetweenWidget,
            ),
          ],
        ),
      ),
    );
  }

  void _chooseLanguage(context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (builder) => const LanguageBottomSheet());
  }

  void _chooseTheme(context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      constraints: const BoxConstraints(
        maxHeight: 300,
      ),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) => const ThemeBottomSheet(),
    );
  }
}
