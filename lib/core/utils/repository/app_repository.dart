import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';

class AppRepository {
  UserInfo? userInfo;
  CountriesEntity? countries;
  Validators? validators;
  List<Posts>? posts;

  AppRepository() {
    String? userInfoString = CacheHelper.getData(key: 'userInfo');
    if (userInfoString != null && userInfoString.isNotEmpty) {
      userInfo = UserInfo.decode(userInfoString);
    }
  }
}
