import 'dart:async';
import 'dart:convert';

import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/Signin.dart';
import 'package:CWCFlutter/features/signin/domain/usecases/sign_up.dart';
import "package:bloc/bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SignUp signUp;
  final Login login;

  SigninBloc({@required this.login, @required this.signUp});
  @override
  SigninState get initialState => SigninInitial();

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is CreateUserEvent) {
      // yield SignUpLoading();

      UserParams params = UserParams(user: event.user);
      var result = await signUp(params);
      yield* result.fold((failure) async* {
        print("dfldskflsdkf");
      }, (result) async* {
        print(json.encode(result));
        yield SignUpLoaded(user: result);
      });
    }
    if (event is ToSignUpEvent) {
      yield SignUpEmptyDisplay();
    }
    if (event is BackEvent) {
      yield SigninInitial();
    }
    if (event is LoginEvent) {
      // yield SignUpLoading();
      LoginParams params =
          LoginParams(email: event.email, password: event.password);
      var result = await login(params);
      yield* result.fold((failure) async* {
        print("dfldskflsdkf");
      }, (result) async* {
        print(json.encode(result));
        yield SignUpLoaded(user: result);
      });
    }
  }
}
