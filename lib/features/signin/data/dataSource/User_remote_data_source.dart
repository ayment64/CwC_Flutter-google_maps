import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';

abstract class UserRemoteDataSource {
  Future<User> create_user(UserParams params);
  Future<User> login(LoginParams params);
}
