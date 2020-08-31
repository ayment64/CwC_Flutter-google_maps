import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:flutter/material.dart';

import '../gmap.dart';

class ToHome extends MaterialPageRoute<Null> {
  ToHome(User token)
      : super(builder: (BuildContext ctx) {
          return new GMap(
            user: token,
          );
        });
}
