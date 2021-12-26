import 'package:Postly/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Badge extends Equatable {
  final String level;
  final String image;

  Badge({@required this.level, @required this.image});

  @override
  // TODO: implement props
  List<Object> get props => [this.image, this.level];

}
