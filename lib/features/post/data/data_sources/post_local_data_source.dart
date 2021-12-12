import 'package:Postly/core/error/exception.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';

abstract class PostLocalDataSource {
  Future<List<Post>> getLocalPost();

  Future<void> cachePost(List<Post> posts);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final HiveRepository hiveRepository;

  PostLocalDataSourceImpl({@required this.hiveRepository});

  @override
  Future<void> cachePost(List<Post> posts) {
    return hiveRepository.add<List<Post>>(
        name: kPostBox, key: kPosts, item: posts);
  }

  @override
  Future<List<Post>> getLocalPost() {
    final localPost =
        hiveRepository.get<List<Post>>(key: kPosts, name: kPostBox);
    if (localPost != null) {
      return Future.value(localPost);
    } else {
      throw CacheException();
    }
  }
}
