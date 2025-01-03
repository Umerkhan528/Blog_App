import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure,SuccessType>> call(Params params);
}

class NoParams{

}