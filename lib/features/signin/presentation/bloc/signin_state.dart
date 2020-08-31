part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SigninInitial extends SigninState {}

class SignUpLoading extends SigninState {}

class SignUpLoaded extends SigninState {
  final User user;

  SignUpLoaded({@required this.user});
}
