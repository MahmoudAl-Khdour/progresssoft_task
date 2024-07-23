import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progresssoft_task/core/helper/cache_helper.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CacheHelper.getData(key: 'deviceType') == 'ios'
        ? CupertinoActivityIndicator(
            color: Theme.of(context).primaryColor,
            animating: true,
          )
        : CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          );
  }
}
