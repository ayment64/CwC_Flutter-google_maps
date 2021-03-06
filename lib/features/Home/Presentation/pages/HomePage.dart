import 'package:CWCFlutter/features/Home/Presentation/bloc/home_bloc.dart';
import 'package:CWCFlutter/features/Home/Presentation/widgets/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Injection_Container.dart';
import '../../../signin/domain/entity/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  @override
  Widget build(BuildContext context) {
    user = widget.user;
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          builder: (_) => sl<HomeBloc>(),
          child: Home(
            user: user,
          ),
        ));
  }
}
