import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/failure.dart';
import 'package:Postly/core/network_info/network_info.dart';
import 'package:Postly/features/post/data/data_sources/post_local_data_source.dart';
import 'package:Postly/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {this.postRemoteDataSource, this.postLocalDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getPost();
        postLocalDataSource.cachePost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getLocalPost();
        return Right(localPosts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
