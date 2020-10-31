import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/core/Usecases.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Repository/Poly_repository.dart';
import 'package:dartz/dartz.dart';

class GetPoly implements Usescases<List<Poly>, String> {
  PolyRepository polyRepository;

  GetPoly(this.polyRepository);

  @override
  Future<Either<Failure, List<Poly>>> call(String params) async {
    return await polyRepository.getPoly(params);
  }
}
