import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:CWCFlutter/features/signin/presentation/widgets/Profile.dart';
import 'package:CWCFlutter/features/signin/presentation/widgets/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Injection_Container.dart';

class SignInPage extends StatefulWidget {
  final bool toProfile;
  final User user;

  const SignInPage({Key key, this.toProfile, this.user}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool toProfile;
  @override
  Widget build(BuildContext context) {
    if (widget.toProfile == null) {
      toProfile = false;
    } else {
      toProfile = widget.toProfile;
    }
    return !toProfile
        ? Scaffold(
            body: BlocProvider(
            builder: (_) => sl<SigninBloc>(),
            child: LoginPage(),
          ))
        : Scaffold(
            body: BlocProvider(
            builder: (_) => sl<SigninBloc>(),
            child: ProfilePage(
              user: widget.user,
            ),
          ));
  }
}
