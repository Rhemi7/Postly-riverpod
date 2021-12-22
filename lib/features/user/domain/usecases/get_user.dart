import 'package:Postly/core/error/failure.dart';
import 'package:Postly/core/usecases/usecase.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:Postly/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser extends UseCase<User, NoParams> {
  final UserRepository userRepository;
  GetUser(this.userRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await userRepository.getUser();
  }
}
