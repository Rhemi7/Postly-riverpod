import 'package:Postly/features/post/data/models/posts/post.dart';

abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoaded extends PostState {
  List<Post> posts;
  PostLoaded({this.posts});
}

class PostError extends PostState {
  String message;
  PostError({this.message});
}
