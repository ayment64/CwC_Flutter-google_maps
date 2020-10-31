import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/core/Usecases.dart';
import 'package:CWCFlutter/features/gmap/Domain/Repository/Poly_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePoly implements Usescases<bool, String> {
  PolyRepository polyRepository;

  DeletePoly(this.polyRepository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await polyRepository.deletePoly(params);
  }
}
