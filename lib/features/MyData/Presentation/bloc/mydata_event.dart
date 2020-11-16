part of 'mydata_bloc.dart';

abstract class MydataEvent extends Equatable {
  const MydataEvent();

  @override
  List<Object> get props => [];

}


class GetAllDataEvent extends MydataEvent {
  final String userID;

  GetAllDataEvent({this.userID});
}

class DeletePolyEvent extends MydataEvent {
  final Poly poly;

  DeletePolyEvent({this.poly});

  


}




