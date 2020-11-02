import 'package:CWCFlutter/core/widgets/LoadingPage.dart';
import 'package:CWCFlutter/features/Home/Presentation/pages/HomePage.dart';
import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool mailErrorVisibility = false;
  bool passwordErrorVisibility = false;

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
      color: Color(0xffFFA91E),
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
          setState(() {
            passwordErrorVisibility = vPassword.length < 6;
          });
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
          setState(() {
            mailErrorVisibility = !RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(vEmail);
          });
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
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
      if (state is SignUpLoading) return LoadingPage();
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/jmal.gif'),
              ),
              SizedBox(height: 48.0),
              email,
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 2, 0, 0),
                child: Visibility(
                    visible: mailErrorVisibility,
                    child: Text(
                      "put a valid email",
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              SizedBox(height: 8.0),
              pass,
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 2, 0, 0),
                  child: Text(
                    "Invalid Password",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                visible: passwordErrorVisibility,
              ),
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
