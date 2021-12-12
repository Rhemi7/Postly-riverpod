import 'dart:io';

import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/failure.dart';
import 'package:Postly/data/data_provider/api_client.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';

import '../../../../locator.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getPost();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<List<Post>> getPost() async {
    var _apiClient = locator<ApiClient>();

    try {
      final data = await _apiClient.get("posts");
      var posts = (data as List).map((e) => Post.fromJson(e)).toList();
      return posts;
    } on ServerException {
      throw ServerException();
      // return (e.toString());
    }
  }
}
