import 'package:CWCFlutter/features/Home/Presentation/pages/HomePage.dart';
import 'package:CWCFlutter/features/gmap/Presentation/Pages/Poly_page.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:CWCFlutter/features/signin/presentation/Pages/Signin_Page.dart';
import 'package:flutter/material.dart';

class ToHome extends MaterialPageRoute<Null> {
  ToHome(User token)
      : super(builder: (BuildContext ctx) {
          return new HomePage(
            user: token,
          );
        });
}

class ToSignup extends MaterialPageRoute<Null> {
  ToSignup(User user)
      : super(builder: (BuildContext ctx) {
          return new SignInPage(
            toProfile: true,
            user: user,
          );
        });
}

class ToMaps extends MaterialPageRoute<Null> {
  ToMaps(User user)
      : super(builder: (BuildContext ctx) {
          return new PolyPage(
            user: user,
          );
        });
}
