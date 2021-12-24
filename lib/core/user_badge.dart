import 'package:Postly/widget/badge.dart';

class UserBadge {
  static Badge getUserBadge(int point) {
    if (point < 6) {
      return Badge(level: 'Beginner', image: 'beginner');
    } else if (point >= 6 && point < 10) {
      return Badge(level: 'Intermediate', image: 'intermediate');
    } else if (point >= 10 && point <= 16) {
      return Badge(level: 'Professional', image: 'professional');
    } else if (point > 16) {
      return Badge(level: 'Legend', image: 'legend');
    }
    return Badge(level: 'Beginner', image: 'beginner');
  }
}
