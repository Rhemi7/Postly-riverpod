import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/widget/pop_up_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CheckPoints {
  HiveServices _hiveServices;
  CheckPoints(this._hiveServices);

  Future<bool> pointCheck(int point) async {
    if (point > 16) {
      _hiveServices.insertPoint(0);
      return true;
    }
    return false;
  }
}
