import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mydata_event.dart';
part 'mydata_state.dart';

class MydataBloc extends Bloc<MydataEvent, MydataState> {
  @override
  Stream<MydataState> mapEventToState(
    MydataEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  // TODO: implement initialState
  MydataState get initialState => MydataInitial();
}
