import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/failure.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();

  // Future<Either<Failure, List<Post>>> getLocalPosts();
}
