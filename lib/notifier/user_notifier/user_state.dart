import 'package:Postly/models/user/user.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded({this.user});
}

class UserError extends UserState {
  String message;
  UserError({this.message});
}
