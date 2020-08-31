import 'package:flutter/material.dart';

import 'Injection_Container.dart';
import 'features/signin/presentation/Pages/Signin_Page.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coding with Curry',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        primaryIconTheme: IconThemeData(color: Colors.white),
        primarySwatch: Colors.lightBlue,
      ),
      home: SignInPage(),
    );
  }
}
