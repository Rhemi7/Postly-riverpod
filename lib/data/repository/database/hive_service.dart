import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:hive/hive.dart';

class HiveServices {
  Box _postBox = Hive.box(kPostBox);
  Box _userBox = Hive.box(kUserBox);

  Future<void> insertPost(List<Post> posts) async {
    _postBox.put(kPosts, posts);
    print('post in hive');
  }

  List<Post> getHivePost() {
    return _postBox.get(kPosts).cast<Post>();
  }

  Future<void> insertUser(User user) async {
    _userBox.put(kUser, user);
    print('user in hive');
  }

  User getHiveUser() {
    return _userBox.get(kUser);
  }
}
