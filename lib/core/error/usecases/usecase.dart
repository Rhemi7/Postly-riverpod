import 'package:Postly/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<Either<ApiFailureException, Type>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
