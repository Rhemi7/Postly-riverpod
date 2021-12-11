import 'dart:io';

import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/posts/post.dart';
import 'package:Postly/notifier/post_nofifier/post_state.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostNotifier extends StateNotifier<PostState> {
  List<Post> vmPosts = [];

  PostServices postServices;
  HiveRepository _hiveRepository;

  PostNotifier(this.postServices, this._hiveRepository) : super(PostInitial());

  Future getPosts() async {
    try {
      state = PostLoading();
      vmPosts = _hiveRepository
          .getList<List<Post>>(key: kPosts, name: kPostBox)
          .cast<Post>();
      // .toList();
      print('vmPost $vmPosts');
      if (vmPosts == null) {
        final List<Post> posts = await postServices.getPosts();
        vmPosts = posts;
        print('postSN $posts');
        _hiveRepository.add<List<Post>>(
            name: kPostBox, key: kPosts, item: posts);
        state = PostLoaded(posts: posts);
      } else {
        state = PostLoaded(posts: vmPosts);
      }
    } catch (e) {
      print('error post');
      print(e.toString());
      state = PostError(message: "error");
    }
  }

  Future<void> createPost({String postTitle, String postText}) async {
    try {
      state = PostLoading();
      var _post = Post(title: postTitle, body: postText);
      vmPosts.add(_post);
      state = PostLoaded(posts: vmPosts);
    } catch (e) {
      state = PostError(message: e.toString());
    }
  }
}
