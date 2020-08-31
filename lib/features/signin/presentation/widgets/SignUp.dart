import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUP extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _SignUPState createState() => new _SignUPState();
}

class _SignUPState extends State<SignUP> {
  String vEmail;
  String vUsername;
  String vFirstname;
  String vLastname;
  String vCin;
  String vPassword;
  String vConfirmPassword;
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) {
        vEmail = value;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        vPassword = value;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        vConfirmPassword = value;
      },
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final username = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vUsername = value;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final firstname = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vFirstname = value;
      },
      decoration: InputDecoration(
        hintText: 'Firstname',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final lastname = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vLastname = value;
      },
      decoration: InputDecoration(
        hintText: 'Lastname',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final cin = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vCin = value;
      },
      decoration: InputDecoration(
        hintText: 'Cin',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          dispatcheventCreateUser();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
    return BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
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
              username,
              SizedBox(height: 8.0),
              firstname,
              SizedBox(height: 8.0),
              lastname,
              SizedBox(height: 8.0),
              cin,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              confirmPassword,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      );
    });
  }

  void dispatcheventCreateUser() {
    BlocProvider.of<SigninBloc>(context).dispatch(CreateUserEvent(
        user: User(
            cin: vCin,
            email: vEmail,
            dateOfCreation: DateTime.now(),
            firstname: vFirstname,
            lastname: vLastname,
            password: vPassword,
            username: vUsername,
            lastLogin: DateTime.now(),
            imageurl:
                'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50')));
  }
}
