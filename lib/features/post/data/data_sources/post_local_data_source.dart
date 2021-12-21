import 'package:Postly/core/error/exception.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';

abstract class PostLocalDataSource {
  Future<List<Post>> getLocalPost();

  Future<void> cachePost(List<Post> posts);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final HiveServices hiveRepository;

  PostLocalDataSourceImpl({@required this.hiveRepository});

  @override
  Future<void> cachePost(List<Post> posts) {
    print('post in hive');
    return hiveRepository.insertPost(posts);
    // return hiveRepository.add<List<Post>>(
    //     name: kPostBox, key: kPosts, item: posts);
    // .cast<Post>();
  }

  @override
  Future<List<Post>> getLocalPost() {
    final localPost = hiveRepository.getHivePost();
    // .get<List<Post>>(key: kPosts, name: kPostBox)
    // .cast<Post>();
    if (localPost != null) {
      return Future.value(localPost);
    } else {
      throw CacheException();
    }
  }
}
