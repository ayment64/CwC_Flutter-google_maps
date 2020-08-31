import 'package:CWCFlutter/core/Exeptions.dart';
import 'package:CWCFlutter/features/signin/data/dataSource/User_remote_data_source.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/features/signin/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  var response;

  UserRepositoryImpl({@required this.remoteDataSource});
  @override
  Future<Either<Failure, User>> create_user(Params params) async {
    try {
      response = await remoteDataSource.create_user(params);
      if (response is String) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(Params params) async {
    try {
      response = await remoteDataSource.login(params);
      if (response is User) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
