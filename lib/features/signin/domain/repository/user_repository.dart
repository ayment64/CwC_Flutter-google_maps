import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> create_user(Params params);
  Future<Either<Failure, User>> login(Params params);
}
