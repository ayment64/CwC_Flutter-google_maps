part of 'mydata_bloc.dart';

abstract class MydataState extends Equatable {
  const MydataState();
  
  @override
  List<Object> get props => [];
}

class MydataInitial extends MydataState {}
