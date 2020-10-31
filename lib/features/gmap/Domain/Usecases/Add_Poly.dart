import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/core/Usecases.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Repository/Poly_repository.dart';
import 'package:dartz/dartz.dart';

class AddPoly implements Usescases<bool, Poly> {
  PolyRepository polyRepository;

  AddPoly(this.polyRepository);

  @override
  Future<Either<Failure, bool>> call(Poly params) async {
    return await polyRepository.addPoly(params);
  }
}
