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
    Map<int, Color> colorCodes = {
      50: Color(0x11FFA91E),
      100: Color(0x33FFA91E),
      200: Color(0x55FFA91E),
      300: Color(0x77FFA91E),
      400: Color(0x99FFA91E),
      500: Color(0xAAFFA91E),
      600: Color(0xBBFFA91E),
      700: Color(0xCCFFA91E),
      800: Color(0xEEFFA91E),
      900: Color(0xFFFFA91E),
    };
    MaterialColor orange = MaterialColor(0xFF93cd48, colorCodes);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camels',
      theme: ThemeData(
        primaryColor: Color(0xffFFA91E),
        primaryIconTheme: IconThemeData(color: Colors.white),
        primarySwatch: orange,
      ),
      home: SignInPage(),
    );
  }
}
