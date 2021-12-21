import 'package:Postly/core/error/exception.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/user/data/models/user/user.dart';

abstract class UserLocalDataSource {
  Future<User> getLocalUser();

  Future<void> cacheUser(User user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  HiveServices _hiveServices;
  UserLocalDataSourceImpl(this._hiveServices);

  @override
  Future<void> cacheUser(User user) async {
    return await _hiveServices.insertUser(user);
  }

  @override
  Future<User> getLocalUser() async {
    final cacheUser = _hiveServices.getHiveUser();
    if (cacheUser != null) {
      return Future.value(cacheUser);
    } else {
      throw CacheException();
    }
  }
}
