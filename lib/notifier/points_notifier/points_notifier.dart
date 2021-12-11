import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointsNotifier extends StateNotifier<int> {
  HiveRepository _hiveRepository;
  PointsNotifier(this._hiveRepository) : super(0);

  void increment() {
    state = state + 2;
    //        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
    _hiveRepository.add<int>(name: kPointsBox, key: kPoints, item: state);
  }

  void getPoints() {
    var points = _hiveRepository.get<int>(key: kPoints, name: kPointsBox);

    if (points == null) {
      state = 0;
    } else {
      state = points;
    }
  }
}
