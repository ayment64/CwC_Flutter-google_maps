import 'package:CWCFlutter/core/Exeptions.dart';
import 'package:CWCFlutter/features/gmap/Data/Datasource/Poly_remote_data_source.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/features/gmap/Domain/Repository/Poly_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class PolyRepositoryImpl implements PolyRepository {
  final PolyRemoteDataSource remoteDataSource;
  var response;

  PolyRepositoryImpl({@required this.remoteDataSource});
  @override
  Future<Either<Failure, bool>> addPoly(Poly params) async {
    try {
      response = await remoteDataSource.addPoly(params);
      if (response == true) {
        return Right(response);
      } else {
        return Left(new AddPolygoneFailure());
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Poly>>> getPoly(String params) async {
    try {
      response = await remoteDataSource.getPoly(params);
      if (response is List<Poly>) {
        return Right(response);
      } else {
        return Left(new AddPolygoneFailure());
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deletePoly(String params) async {
    try {
      response = await remoteDataSource.deletePoly(params);
      if (response == true) {
        return Right(response);
      } else {
        return Left(new DeletePolyGoneFailure());
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
