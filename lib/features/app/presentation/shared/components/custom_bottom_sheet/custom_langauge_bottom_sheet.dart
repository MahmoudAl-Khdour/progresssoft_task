import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/core/utils/constant/app_sizes.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Get.locale;

    AppSizeConfig.init(context);
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
                Get.updateLocale(const Locale('en'));
                CacheHelper.setData(key: 'lang', value: 'en');
                Get.back();
              },
              title: Text(
                'English',
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      fontSize: 16,
                    ),
              ),
              trailing: locale == const Locale('en')
                  ? Icon(
                      Icons.check_box,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
            ListTile(
              onTap: () {
                Get.updateLocale(const Locale('ar'));
                CacheHelper.setData(key: 'lang', value: 'ar');
                Get.back();
              },
              title: Text(
                'Arabic (العربية)'.tr,
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      fontSize: 16,
                    ),
              ),
              trailing: locale == const Locale('ar')
                  ? Icon(
                      Icons.check_box,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
