import 'package:CWCFlutter/features/Home/Presentation/pages/HomePage.dart';
import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signin_bloc.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String vEmail;
  String vPassword;
  @override
  Widget build(BuildContext context) {
    final loginButton = MaterialButton(
      onPressed: () {
        dispatcheventlogin();
      },
      child: Text(
        'SIGN IN',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'SFUIDisplay',
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.lightBlue,
      elevation: 0,
      minWidth: 400,
      height: 50,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
    final signup = FlatButton(
      child: Text(
        "Don't have an account ?",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        dispqtcheventGoToSignUp();
      },
    );

    final pass = Container(
      child: TextFormField(
        onChanged: (value) {
          vPassword = value;
        },
        obscureText: true,
        style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            labelStyle: TextStyle(fontSize: 15)),
      ),
    );
    final email = Container(
      child: TextFormField(
        onChanged: (value) {
          vEmail = value;
        },
        style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            labelStyle: TextStyle(fontSize: 15)),
      ),
    );
    return BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
      if (state is SignUpLoaded) {
        return HomePage(user: state.user);
      }
      if (state is SignUpEmptyDisplay) {
        return SignUP();
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              pass,
              SizedBox(height: 8.0),
              loginButton,
              signup,
              forgotLabel,
            ],
          ),
        ),
      );
    });
  }

  void dispatcheventlogin() {
    BlocProvider.of<SigninBloc>(context)
        .dispatch(LoginEvent(email: vEmail, password: vPassword));
  }

  void dispqtcheventGoToSignUp() {
    BlocProvider.of<SigninBloc>(context).dispatch(ToSignUpEvent());
  }
}
