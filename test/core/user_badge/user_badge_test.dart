import 'package:Postly/core/user_badge.dart';
import 'package:Postly/widget/badge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User badge', () {
    test('Score of 0 should return beginner badge', () {
      Badge result = UserBadge.getUserBadge(0);
      expect(result, Badge(level: 'Beginner', image: 'beginner'));
    });

    test('Score of 5 should return beginner badge', () {
      Badge result = UserBadge.getUserBadge(5);
      expect(result, Badge(level: 'Beginner', image: 'beginner'));
    });

    test('Score of 8 should return beginner badge', () {
      Badge result = UserBadge.getUserBadge(8);
      expect(result, Badge(level: 'Intermediate', image: 'intermediate'));
    });

    test('Score of 11 should return beginner badge', () {
      Badge result = UserBadge.getUserBadge(11);
      expect(result, Badge(level: 'Professional', image: 'professional'));
    });

    test('Score of 17 should return beginner badge', () {
      Badge result = UserBadge.getUserBadge(17);
      expect(result, Badge(level: 'Legend', image: 'legend'));
    });
  });
}
