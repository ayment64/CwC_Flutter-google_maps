part of 'mydata_bloc.dart';

abstract class MydataState extends Equatable {
  const MydataState();
  
  @override
  List<Object> get props => [];
}

class MydataInitial extends MydataState {}

class MyDataLoading extends MydataState {}

class MyDataLoadedSuccessfully extends MydataState {
  final List<Poly> listpoly;

  MyDataLoadedSuccessfully({this.listpoly});
}

class MyDataFailure extends MydataState {}

class PolyFailedToDelete extends MydataState {}

class PolyDeletedSuccessfully extends MydataState {}

class PolyDeleting extends MydataState {}




