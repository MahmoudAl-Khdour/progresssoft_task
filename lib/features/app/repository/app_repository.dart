import 'package:progresssoft_task/core/helper/cache_helper.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';

class AppRepository {
  UserInfo? userInfo;
  AppRepository() {
    String userInfoString = CacheHelper.getData(key: 'userInfo') ?? '';
    if (userInfoString.isNotEmpty) {
      userInfo = UserInfo.decode(userInfoString);
    }
  }
}
