import 'dart:async';

import 'package:CWCFlutter/core/widgets/LoadingPage.dart';
import 'package:CWCFlutter/features/MyData/Presentation/bloc/mydata_bloc.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyData extends StatefulWidget {
  final User user;
  // test
  final Poly poly;

  const MyData({Key key, this.user, this.poly}) : super(key: key);
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool inited = true;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MydataBloc, MydataState>(builder: (context, state) {
      if (state is MydataInitial) {
        dispatchGetAllDataEvent();
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("My Data !!")));
      }
      if (state is MyDataLoading) {
        return LoadingPage();
      }
      if (state is MyDataLoadedSuccessfully) {
        return new ListView.builder(
            itemCount: state.listpoly.length,
            itemBuilder: (BuildContext ctxt, int index) =>
                buildBody(ctxt, state.listpoly[index]));
      }
      if (state is PolyDeleting) {
        return LoadingPage();
      }
      // if (state is PolyDeletedSuccessfully)
      // {
      //   dispatchDeletePolyEvent();

      // }
      return Container();
    });
  }

  Widget buildBody(BuildContext ctx, dynamic item) {
    bool visibe = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: InkWell(
          onTap: () {
            setState(() {
              print("lalalallalalallalalalallalalla");
              visibe = !visibe;
            });
          },
          child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(item.color),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.type ?? "not available ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "#" + item.sId,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Row(
                            children: [
                              Text(
                                "Owner Name : ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.ownerName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Owner Last Name : ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.ownerLastName ?? "not available",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Owner Phone Number : ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.ownerPhoneNumber ?? "not availble ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: visibe,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Owner Adress : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      item.ownerAdress ?? "not available ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Area of terrain : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${item.areaOfTerrain} ${item.areaOfTerrainUnit}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              dispatchDeletePolyEvent(item.sId);
            },
          ),
        ],
      ),
    ); //item.areaOfTerrain
  }

  void dispatchGetAllDataEvent() {
    BlocProvider.of<MydataBloc>(context)
        .dispatch(GetAllDataEvent(userID: widget.user.sId));
  }

  // test
  void dispatchDeletePolyEvent(String id) {
    BlocProvider.of<MydataBloc>(context).dispatch(DeletePolyEvent(id: id));
  }
}
