import 'package:dartz/dartz.dart';

import 'Failure.dart';

abstract class Usescases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
