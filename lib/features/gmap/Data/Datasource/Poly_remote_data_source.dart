import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Delete_poly.dart';

abstract class PolyRemoteDataSource {
  Future<bool> addPoly(Poly params);
  Future<bool> deletePoly(String params);
  Future<List<Poly>> getPoly(String params);
}
