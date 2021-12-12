import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/usecases/usecase.dart';
import 'package:Postly/features/post/data/data_sources/post_repository.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:dartz/dartz.dart';

class GetPost extends UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;
  GetPost({this.postRepository});

  @override
  Future<Either<ApiFailureException, List<Post>>> call(NoParams params) async {
    return await postRepository.getNetworkPosts();
  }
}
