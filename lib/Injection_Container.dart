import 'package:CWCFlutter/features/Home/Presentation/bloc/home_bloc.dart';
import 'package:CWCFlutter/features/MyData/Presentation/bloc/mydata_bloc.dart';
import 'package:CWCFlutter/features/gmap/Data/Datasource/Implementation/Poly_remote_data_source_impl.dart';
import 'package:CWCFlutter/features/gmap/Data/Datasource/Poly_remote_data_source.dart';
import 'package:CWCFlutter/features/gmap/Domain/Repository/Poly_repository.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Add_Poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Delete_poly.dart';
import 'package:CWCFlutter/features/gmap/Domain/Usecases/Get_poly.dart';
import 'package:CWCFlutter/features/gmap/Presentation/bloc/poly_bloc.dart';
import 'package:CWCFlutter/features/signin/data/dataSource/Implementation/User_remote_data_source_impl.dart';
import 'package:CWCFlutter/features/signin/data/dataSource/User_remote_data_source.dart';
import 'package:CWCFlutter/features/signin/data/repository/User_repository_impl.dart';
import 'package:CWCFlutter/features/signin/domain/repository/user_repository.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/Signin.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'features/gmap/Data/Repository/Poly_repository_impl.dart';
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
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSpourceImpl(client: sl()));
  // ? --------------------------------        home       --------------------------------
  // * --------------------------------        bloc       --------------------------------
  sl.registerFactory(() => HomeBloc());
  // ? --------------------------------        Maps       --------------------------------
  // * --------------------------------        bloc       --------------------------------
  sl.registerFactory(
      () => PolyBloc(addPoly: sl(), getPoly: sl(), deletePoly: sl()));
  // * --------------------------------      UseCases     --------------------------------
  sl.registerLazySingleton(() => AddPoly(sl()));
  sl.registerLazySingleton(() => DeletePoly(sl()));
  sl.registerLazySingleton(() => GetPoly(sl()));
  // * --------------------------------     Reposiroys    --------------------------------
  sl.registerLazySingleton<PolyRepository>(
      () => PolyRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<PolyRemoteDataSource>(
      () => PolyRemoteDataSourceImpl(client: sl()));

  // ? ------------------------------ MyData --------------------------------
  // * --------------------------------        bloc       --------------------------------

  sl.registerFactory(
      () => MydataBloc(getPoly: sl(), deletePoly: sl()));
  // ! --------------------------------      Externals    ---------------------------------
  sl.registerLazySingleton(() => http.Client());
}
