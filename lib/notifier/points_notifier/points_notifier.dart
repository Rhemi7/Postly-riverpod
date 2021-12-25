import 'package:Postly/core/check_points.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsNotifier extends StateNotifier<int> {
  HiveServices _hiveServices;
  CheckPoints _checkPoints;
  PointsNotifier(this._hiveServices, this._checkPoints) : super(0);

  void increment() async {
    state = state + 2;
    //        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
    await _hiveServices.insertPoint(state);
  }

  void getPoints(context) async {
    int points = await  _checkPoints.pointCheck(context);
    if (points == null) {
      state = 0;
    } else {
      state = points;
    }
  }
}
