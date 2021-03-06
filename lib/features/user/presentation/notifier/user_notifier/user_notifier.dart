import 'dart:math';

import 'package:Postly/core/usecases/usecase.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:Postly/features/user/domain/usecases/get_user.dart';
import 'package:Postly/features/user/presentation/notifier/user_notifier/user_state.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserState> {
  GetUser getPostlyUser;
  // HiveRepository _hiveRepository;
  User _user;
  User get user => _user;
  UserNotifier(this.getPostlyUser) : super(UserInitial());

  Future<void> getUser() async {
    try {
      state = UserLoading();
      final result = await getPostlyUser(NoParams());
      result.fold((error) => state = UserError(message: "Error"), (user) {
        _user = user;
        state = UserLoaded(user: _user);
      });
      // _user = _hiveRepository.get<User>(key: kUser, name: kUserBox);
      // if (_user == null) {
      //   final List<User> users = await _userServices.getUsers();
      //   int index = Random().nextInt(users.length);
      //   _user = users[index];
      //   _hiveRepository.add<User>(name: kUserBox, key: kUser, item: _user);
      //   state = UserLoaded(user: _user);
      // } else {
      //   state = UserLoaded(user: _user);
      // }
    } catch (e) {
      state = UserError(message: e.toString());
    }
  }
}
