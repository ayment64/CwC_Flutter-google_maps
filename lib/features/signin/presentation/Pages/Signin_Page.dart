import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:CWCFlutter/features/signin/presentation/widgets/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Injection_Container.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      builder: (_) => sl<SigninBloc>(),
      child: LoginPage(),
    ));
  }
}
