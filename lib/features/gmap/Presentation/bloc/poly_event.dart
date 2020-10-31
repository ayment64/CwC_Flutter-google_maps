part of 'poly_bloc.dart';

abstract class PolyEvent extends Equatable {
  const PolyEvent();

  @override
  List<Object> get props => [];
}

class AddPolyEvent extends PolyEvent {
  final Poly poly;

  AddPolyEvent({@required this.poly});
}

class InitEvent extends PolyEvent {
  final String id;

  InitEvent({@required this.id});
}

class DeletePolyEvent extends PolyEvent {
  final String id;

  DeletePolyEvent({@required this.id});
}

class ReInitiateEvent extends PolyEvent {}
