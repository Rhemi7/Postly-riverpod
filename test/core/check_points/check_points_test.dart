import 'package:Postly/core/check_points.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HiveServicesMock extends Mock implements HiveServices {}

main() {
  HiveServicesMock hiveServicesMock;
  CheckPoints checkPoints;
  setUp(() {
    hiveServicesMock = HiveServicesMock();
    checkPoints = CheckPoints(hiveServicesMock);
  });

  int smallPoint = 6;
  int bigPoint = 18;

  group('Check points', () {
    test('Get points from hive local storage', () async {
      when(hiveServicesMock.getUserPoint()).thenAnswer((_) async => smallPoint);

      var result = await hiveServicesMock.getUserPoint();

      expect(result, smallPoint);
    });

    // test('Check point and return bool', () {
    //   checkPoints.pointCheck();
    //
    // });
  });
}
