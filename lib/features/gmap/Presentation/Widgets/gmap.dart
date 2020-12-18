import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:CWCFlutter/core/Routing.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/gmap/Presentation/bloc/poly_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

import '../../../signin/domain/entity/user.dart';

class GMap extends StatefulWidget {
  final User user;
  GMap({Key key, @required this.user}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  List<LatLng> points = List<LatLng>();
  double strokewidth = 0;
  Color polygonCurrentColor = Colors.teal;
  bool isSelected = false;
  PolygonId selectedPolygon;
  bool deleteMode = false;
  int randomNumber;
  bool initiated = false;
  GoogleMapController _mapController;
  String ownername;
  String ownerlastname;
  String ownerphonenumber;
  String owneradress;
  String type;
  String unit;
  int area;
  bool inited = true;
  @override
  void initState() {
    super.initState();
  }

  void _setPolygons() {
    Random random = new Random();
    randomNumber = random.nextInt(100);

    setState(() {
      _polygons.add(
        Polygon(
          polygonId: PolygonId("$randomNumber"),
          points: points,
          fillColor: polygonCurrentColor,
          strokeColor: polygonCurrentColor,
          strokeWidth: 1,
          consumeTapEvents: true,
          onTap: () {
            print("poly tap");
          },
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolyBloc, PolyState>(
      builder: (context, state) {
        print(state.toString());
        if (state is PolyInitial) {
          _polygons.clear();
          dispatchInitEvent();
        }
        if (state is Ployloaded && !initiated) {
          for (Poly p in state.listpoly) {
            for (Points pp in p.points) {
              points.add(LatLng(pp.point.lat, pp.point.long));
            }

            Random random = new Random();

            randomNumber = random.nextInt(100);
            _polygons.add(
              Polygon(
                polygonId: PolygonId(p.sId),
                points: points,
                fillColor: Color(p.color),
                strokeColor: Color(p.color),
                strokeWidth: 1,
                consumeTapEvents: true,
                onTap: () {
                  print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                  print(PolygonId(p.sId));
                  print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                  setState(() {
                    selectedPolygon = PolygonId(p.sId);

                    isSelected = !isSelected;
                  });
                },
              ),
            );
            points = List();
            _circles = HashSet<Circle>();
            _polylines = HashSet<Polyline>();
          }
          initiated = true;
        }
        return Stack(
          children: <Widget>[
            GoogleMap(
              onTap: (point) {
                if (!deleteMode) {
                  drawline();
                  addpoints(point);
                }
              },
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(36.8065, 10.1815),
                zoom: 12,
              ),
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              circles: Set<Circle>.of(_circles),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SearchMapPlaceWidget(
                  apiKey: "AIzaSyBqM5kFfDOSAuJEV1OuSkLkrdqVJJsec0w",
                  // The language of the autocompletion
                  language: 'en',
                  // The position used to give better recomendations. In this case we are using the user position
                  location: LatLng(36.8065, 10.1815),
                  radius: 30000,
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;

                    // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                    final GoogleMapController controller = _mapController;
                    controller.animateCamera(
                        CameraUpdate.newLatLng(geolocation.coordinates));
                    controller.animateCamera(
                        CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                child: Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Visibility(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: "shee",
                          onPressed: () {
                            print("-------------------------------");
                            print(selectedPolygon.value);
                            print("-------------------------------");
                            dispatchDeleteEvent(selectedPolygon.value);
                            setState(() {
                              print("################################");
                              print(selectedPolygon);
                              print("################################");
                              _polygons.removeWhere((element) =>
                                  element.polygonId == selectedPolygon);
                              isSelected = !isSelected;
                              initiated = false;
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      visible: isSelected,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: polygonCurrentColor,
                            onColorChanged: (value) {
                              setState(() {
                                polygonCurrentColor = value;
                              });
                            },
                            enableLabel: true,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(0X00000000),
                    child: Image(
                      height: 50,
                      width: 50,
                      image: AssetImage('assets/images/color_picker.png'),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: points.length > 2,
                child: InkWell(
                  onTap: () {
                    showDialog(
                            child:
                                StatefulBuilder(builder: (context, snapshot) {
                              return new Dialog(
                                child: SingleChildScrollView(
                                  child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                0.6) +
                                            118,
                                    child: new Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                ownername = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Owner Name',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                ownerlastname = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Owner Last Name',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                ownerphonenumber = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Owner Phone Number',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                owneradress = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Owner Adress',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                area = int.parse(value);
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Area Of terrain',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                unit = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Unit',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                type = value;
                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'SFUIDisplay'),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Type',
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                labelStyle:
                                                    TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        new FlatButton(
                                          color: Colors.lightBlue,
                                          child: new Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            context: context)
                        .then((value) {
                      dispatchAddPolyEvent();
                      setState(() {
                        points = List();
                        _circles = HashSet<Circle>();
                        _polylines = HashSet<Polyline>();
                      });

                      initiated = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Color(0X00000000),
                      child: Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('assets/images/save.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  height: 75,
                  width: points.length < 1
                      ? MediaQuery.of(context).size.height - 260
                      : MediaQuery.of(context).size.height - 300,
                  child: Slider(
                    divisions: 100,
                    label: '$strokewidth',
                    min: 0,
                    max: 100,
                    value: strokewidth,
                    onChanged: (value) {
                      setState(() {
                        strokewidth = value;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void addpoints(LatLng point) {
    print("poof");
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    setState(() {
      points.add(point);
      _circles.add(
        Circle(
            circleId: CircleId("$randomNumber"),
            center: point,
            radius: strokewidth,
            strokeWidth: 2,
            fillColor: polygonCurrentColor),
      );
    });
    print(_circles.length);
  }

  void drawline() {
    print("points number ${points.length}");

    Random random = new Random();
    setState(() {
      int randomNumber = random.nextInt(100);

      print('am in ');
      _polylines.add(
        Polyline(
          polylineId: PolylineId("$randomNumber"),
          points: points,
          color: polygonCurrentColor,
          width: 1,
        ),
      );
    });
  }

  List<Points> _addpoints() {
    List<Points> p = new List();
    for (LatLng data in points) {
      p.add(Points(point: Point(lat: data.latitude, long: data.longitude)));
    }
    return p;
  }

  void dispatchAddPolyEvent() {
    print(toString());
    BlocProvider.of<PolyBloc>(context).dispatch(AddPolyEvent(
        poly: Poly(
            areaOfTerrain: area,
            points: _addpoints(),
            areaOfTerrainUnit: unit,
            color: polygonCurrentColor.value,
            ownerAdress: owneradress,
            ownerLastName: ownerlastname,
            ownerName: ownername,
            ownerPhoneNumber: ownerphonenumber,
            type: type,
            polygonId: randomNumber,
            user: widget.user.sId)));
  }

  void dispatchInitEvent() {
    BlocProvider.of<PolyBloc>(context).dispatch(InitEvent(id: widget.user.sId));
  }

  void dispatchDeleteEvent(String id) {
    BlocProvider.of<PolyBloc>(context).dispatch(DeletePolyEvent(id: id));
  }

  void dispatchreinitiateEvent() {
    _polygons.clear();
    BlocProvider.of<PolyBloc>(context).dispatch(ReInitiateEvent());
  }
}
