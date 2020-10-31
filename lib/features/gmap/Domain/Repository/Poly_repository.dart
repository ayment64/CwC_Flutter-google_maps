import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:dartz/dartz.dart';

abstract class PolyRepository {
  Future<Either<Failure, bool>> addPoly(Poly params);
  Future<Either<Failure, List<Poly>>> getPoly(String params);
  Future<Either<Failure, bool>> deletePoly(String params);
}
