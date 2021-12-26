import 'package:Postly/core/check_points.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsNotifier extends StateNotifier<int> {
  HiveServices _hiveServices;
  CheckPoints _checkPoints;
  PointsNotifier(this._hiveServices, this._checkPoints) : super(0);

  bool _greaterThanSixteen;
  bool get greaterThanSixteen => _greaterThanSixteen;

  int _point;
  int get point => _point;

  void increment() async {
    state = state + 2;
    //        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
    await _hiveServices.insertPoint(state);
  }

  // Future<bool> checkPoints() async {
  //   await getPoints();
  //   _greaterThanSixteen = await _checkPoints.pointCheck(_point);
  //   return _greaterThanSixteen;
  // }

  Future<int> getPoints() async {
    _point = await _hiveServices.getUserPoint();
    if (_point == null) {
      state = 0;
      _point = 0;
    } else {
      state = _point;
    }
    return _point;
  }

  clearPoint() {
    state = 0;
    _hiveServices.insertPoint(0);
  }
}
