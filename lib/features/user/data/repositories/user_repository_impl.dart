import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/failure.dart';
import 'package:Postly/core/platform/network_info.dart';
import 'package:Postly/features/user/data/data_sources/user_local_data_source.dart';
import 'package:Postly/features/user/data/data_sources/user_remote_date_source.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:Postly/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(
      {this.networkInfo, this.userRemoteDataSource, this.userLocalDataSource});

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        User user = await userLocalDataSource.getLocalUser();
        if (user != null) {
          return Right(user);
        } else {
          User user = await userRemoteDataSource.getUser();
          userLocalDataSource.cacheUser(user);
          return Right(user);
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        User user = await userLocalDataSource.getLocalUser();
        return Right(user);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
