import 'package:CWCFlutter/features/signin/data/dataSource/Implementation/User_remote_data_source_impl.dart';
import 'package:CWCFlutter/features/signin/data/dataSource/User_remote_data_source.dart';
import 'package:CWCFlutter/features/signin/data/repository/User_repository_impl.dart';
import 'package:CWCFlutter/features/signin/domain/repository/user_repository.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/Signin.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'features/signin/presentation/bloc/signin_bloc.dart';

final sl = GetIt.instance;
void init() {
  // ? -------------------------------- Sign in / sign up --------------------------------
  // * --------------------------------        bloc       --------------------------------
  sl.registerFactory(() => SigninBloc(signUp: sl(), login: sl()));
  // * --------------------------------      UseCases     --------------------------------

  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  // * --------------------------------     Reposiroys    --------------------------------
  // * --------------------------------     Reposiroys    --------------------------------
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSpourceImpl(client: sl()));
  // ! --------------------------------      Externals    ---------------------------------
  sl.registerLazySingleton(() => http.Client());
}
