import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signin_bloc.dart';

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
          border: OutlineInputBorder(),
          labelText: 'Email',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        vPassword = value;
      },
      style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        vConfirmPassword = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Confirm Password',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );
    final username = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vUsername = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );
    final firstname = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vFirstname = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Firstname',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );
    final lastname = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vLastname = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Lastname',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );
    final cin = TextFormField(
      autofocus: false,
      obscureText: false,
      onChanged: (value) {
        vCin = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Cin',
          prefixIcon: Icon(Icons.lock_outline),
          labelStyle: TextStyle(fontSize: 15)),
    );

    final loginButton = MaterialButton(
      onPressed: () {
        dispatcheventCreateUser();
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

    return BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              InkWell(
                onTap: () {
                  dispatchBackEvent();
                },
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Icon(
                      Icons.arrow_back_ios,
                      color: Colors.lightBlue,
                      size: 22.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: new Text('Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.lightBlue)),
                    )
                  ],
                ),
              ),
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

  void dispatchBackEvent() {
    BlocProvider.of<SigninBloc>(context).dispatch(BackEvent());
  }
}
