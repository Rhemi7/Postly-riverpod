import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PostEntity extends Equatable {
  PostEntity({
    @required this.userId,
    this.id,
    this.title,
    this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  // TODO: implement props
  List<Object> get props => [id, title, body, userId];
}
