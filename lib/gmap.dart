import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

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

  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void _setPolygons() {
    Random random = new Random();
    int randomNumber = random.nextInt(100);

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
            setState(() {
              selectedPolygon = PolygonId("$randomNumber");
              
              isSelected = !isSelected;
            });
          },
        ),
      );
      points = List();
      _circles = HashSet<Circle>();
      _polylines = HashSet<Polyline>();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
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
                          setState(() {
                            _polygons.removeWhere((element) =>
                                element.polygonId == selectedPolygon);
                            isSelected = !isSelected;
                          });
                        },
                        child: Icon(Icons.delete),
                      ),
                    ),
                    visible: isSelected,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: [
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: "mee",
                      onPressed: () {
                        setState(() {
                          points = List();
                          _circles = HashSet<Circle>();
                          _polylines = HashSet<Polyline>();
                        });
                      },
                      child: Icon(Icons.delete),
                    ),
                  ),
                  visible: points.length > 0,
                ),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: "exodia",
                      onPressed: () {
                        _setPolygons();
                      },
                      child: Icon(Icons.save),
                    ),
                  ),
                  visible: points.length > 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: "exodiqqa",
                    onPressed: () {
                      setState(() {
                        deleteMode = !deleteMode;
                      });
                    },
                    child: Icon(Icons.delete_outline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: "raa",
                    onPressed: () {
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
                                    print('${polygonCurrentColor.value}');
                                  });
                                },
                                enableLabel: true,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.color_lens),
                  ),
                ),
              ],
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
      ),
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
}
