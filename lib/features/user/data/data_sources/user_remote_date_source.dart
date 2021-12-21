import 'dart:math';

import 'package:Postly/core/error/exception.dart';
import 'package:Postly/data/data_provider/api_client.dart';
import 'package:Postly/features/user/data/models/user/user.dart';

import '../../../../locator.dart';

abstract class UserRemoteDataSource {
  Future<User> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<User> getUser() async {
    var _apiClient = sl<ApiClient>();

    try {
      final data = await _apiClient.get("users");
      var users = (data as List).map((e) => User.fromJson(e)).toList();
      return users[Random().nextInt(users.length)];
    } on ServerException {
      throw ServerException();
      // return (e.toString());
    }
  }
}
