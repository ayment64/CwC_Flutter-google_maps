part of 'poly_bloc.dart';

abstract class PolyState extends Equatable {
  const PolyState();

  @override
  List<Object> get props => [];
}

class LoadingGmap extends PolyState {}

class PolyInitial extends PolyState {}

class Ployloaded extends PolyState {
  final List<Poly> listpoly;

  Ployloaded({@required this.listpoly});
}

class PloyFailed extends PolyState {}
