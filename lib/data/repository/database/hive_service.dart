import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:hive/hive.dart';

class HiveServices {
  Box _postBox = Hive.box(kPostBox);

  Future<void> insertPost(List<Post> posts) async {
    _postBox.put(kPosts, posts);
    print('post in hive');
  }

  List<Post> getHivePost() {
    return _postBox.get(kPosts).cast<Post>();
  }
}
