import 'package:Postly/core/error/failure.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
