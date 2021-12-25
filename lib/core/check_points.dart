import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/widget/pop_up_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CheckPoints {
  HiveServices _hiveServices;
  CheckPoints(this._hiveServices);

  Future<int> pointCheck(BuildContext context) async {
    var point = await _hiveServices.getUserPoint();
    if (point > 16) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => PopupDialog(),
      );
      _hiveServices.insertPoint(0);
    }
    return _hiveServices.getUserPoint();
  }
}
