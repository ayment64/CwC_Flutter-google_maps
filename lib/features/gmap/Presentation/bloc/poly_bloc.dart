import 'dart:async';

import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Add_Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Delete_poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Get_poly.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'poly_event.dart';
part 'poly_state.dart';

class PolyBloc extends Bloc<PolyEvent, PolyState> {
  final AddPoly addPoly;
  final GetPoly getPoly;
  final DeletePoly deletePoly;

  PolyBloc(
      {@required this.deletePoly,
      @required this.getPoly,
      @required this.addPoly});
  @override
  Stream<PolyState> mapEventToState(
    PolyEvent event,
  ) async* {
    if (event is AddPolyEvent) {
      yield LoadingGmap();
      var result = await addPoly(event.poly);
      yield* result.fold((failure) async* {
        print("dfldskflsdkf");
        yield PloyFailed();
      }, (result) async* {
        yield PolyInitial();
      });
    }
    if (event is InitEvent) {
      yield LoadingGmap();
      var result = await getPoly(event.id);
      yield* result.fold((failure) async* {
        print("dfldskflsdkf");
        yield PloyFailed();
      }, (result) async* {
        print(" got them success");
        yield Ployloaded(listpoly: result);
      });
    }
    if (event is DeletePolyEvent) {
      var result = await deletePoly(event.id);
      yield* result.fold((failure) async* {
        print("dfldskflsdkf");
        yield PloyFailed();
      }, (result) async* { 
        print("deleted successfully");
        yield PolyInitial();
      });
    }
    if (event is ReInitiateEvent) {
      yield PolyInitial();
    }
  }

  @override
  PolyState get initialState => new PolyInitial();
}
