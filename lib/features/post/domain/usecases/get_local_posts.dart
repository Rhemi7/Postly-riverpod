// import 'package:Postly/core/error/exception.dart';
// import 'package:Postly/core/error/failure.dart';
// import 'package:Postly/core/usecases/usecase.dart';
// import 'package:Postly/features/post/domain/repositories/post_repository.dart';
// import 'package:Postly/features/post/data/models/posts/post.dart';
// import 'package:dartz/dartz.dart';
//
// class GetLocalPost extends UseCase<List<Post>, NoParams> {
//   final PostRepository postRepository;
//   GetLocalPost({this.postRepository});
//
//   @override
//   Future<Either<Failure, List<Post>>> call(NoParams params) async {
//     return await postRepository.getLocalPosts();
//   }
// }
