import 'package:Postly/core/error/exception.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<ApiFailureException, List<Post>>> getNetworkPosts();

  Future<Either<ApiFailureException, List<Post>>> getLocalPosts();
}
