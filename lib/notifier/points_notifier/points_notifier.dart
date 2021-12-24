import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsNotifier extends StateNotifier<int> {
  HiveServices _hiveServices;
  PointsNotifier(this._hiveServices) : super(0);

  void increment() async {
    state = state + 2;
    //        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
    await _hiveServices.insertPoint(state);
  }

  void getPoints() {
    var points = _hiveServices.getUserPoint();
    if (points == null) {
      state = 0;
    } else {
      state = points;
    }
  }
}
