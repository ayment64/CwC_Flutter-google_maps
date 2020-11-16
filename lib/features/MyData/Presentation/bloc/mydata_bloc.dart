import 'dart:async';

import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Delete_poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Get_poly.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mydata_event.dart';
part 'mydata_state.dart';

class MydataBloc extends Bloc<MydataEvent, MydataState> {
  final GetPoly getPoly;
  final DeletePoly deletePoly;

  MydataBloc({this.getPoly, this.deletePoly});
  @override
  MydataState get initialState => MydataInitial();

  @override
  Stream<MydataState> mapEventToState(
    MydataEvent event,
  ) async* {
    if (event is GetAllDataEvent) {
      yield MyDataLoading();
      var response = await getPoly(event.userID);
      yield* response.fold((failure) async* {
        yield MyDataFailure();
        print("MyDataFailure");
      }, (result) async* {
        yield MyDataLoadedSuccessfully(listpoly: result);
        print("MyDataLoadedSuccessfully");
      });
    }
    if (event is DeletePolyEvent) {
      yield MyDataLoading();
      var response = await deletePoly(event.id);
      yield* response.fold((failure) async* {
        yield PolyFailedToDelete();
      }, (result) async* {
        yield MydataInitial();
      });
    }
  }
}
