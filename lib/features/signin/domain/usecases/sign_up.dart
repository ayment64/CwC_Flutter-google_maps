import 'package:CWCFlutter/core/Failure.dart';
import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/core/Usecases.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class SignUp implements Usescases<User, Params> {
  UserRepository userRepository;

  SignUp(this.userRepository);
  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await userRepository.create_user(params);
  }
}
