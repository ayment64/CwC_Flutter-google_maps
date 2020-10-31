import 'package:CWCFlutter/core/Routing.dart';
import 'package:CWCFlutter/features/Home/Presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../signin/domain/entity/user.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 190.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/as.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: new Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(ToSignup(user));
                                },
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 60.0,
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/images/profile.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(ToMaps(user));
                                },
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 60.0,
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/images/addlocation.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "add terrain",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 60.0,
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/images/logoutpng.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
