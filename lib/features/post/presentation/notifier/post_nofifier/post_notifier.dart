import 'dart:io';

import 'package:Postly/core/usecases/usecase.dart';
import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/features/post/domain/usecases/get_post.dart';
import 'package:Postly/features/post/presentation/notifier/post_nofifier/post_state.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostNotifier extends StateNotifier<PostState> {
  List<Post> vmPosts = [];

  // PostServices postServices;
  GetPost getAllPost;
  HiveServices _hiveRepository;

  PostNotifier(this.getAllPost, this._hiveRepository) : super(PostInitial());

  Future getPosts() async {
    try {
      state = PostLoading();
      // vmPosts = _hiveRepository
      //     .getList<List<Post>>(key: kPosts, name: kPostBox)
      //     .cast<Post>();
      // .toList();
      print('vmPost $vmPosts');
      // if (vmPosts == null) {
      final result = await getAllPost(NoParams());

      result.fold((error) => state = PostError(message: "Error"), (posts) {
        vmPosts = posts;
        state = PostLoaded(posts: vmPosts);
      });
      // vmPosts = r;
      // print('postSN $r');
      // _hiveRepository.add<List<Post>>(
      //     name: kPostBox, key: kPosts, item: posts);
      // state = PostLoaded(posts: posts);
      // } else {
      //   state = PostLoaded(posts: vmPosts);
      // }
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
