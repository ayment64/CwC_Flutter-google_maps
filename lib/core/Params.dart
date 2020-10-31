import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:meta/meta.dart';

class Params {}

class UserParams extends Params {
  final User user;

  UserParams({this.user});
}

class LoginParams extends Params {
  final String email;
  final String password;

  LoginParams({@required this.email, @required this.password});
}
