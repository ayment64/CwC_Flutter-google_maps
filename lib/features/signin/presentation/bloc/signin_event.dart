part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends SigninEvent {
  final User user;

  CreateUserEvent({@required this.user});
}

class LoginEvent extends SigninEvent {
  final String email;
  final String password;

  LoginEvent({@required this.email, @required this.password});
}

class ToSignUpEvent extends SigninEvent {}

class BackEvent extends SigninEvent {}
