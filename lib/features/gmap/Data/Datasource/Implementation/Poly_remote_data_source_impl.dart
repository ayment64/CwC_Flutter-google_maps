import 'dart:convert';
import 'dart:io';

import 'package:CWCFlutter/core/Environment.dart';
import 'package:CWCFlutter/core/Exeptions.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../Poly_remote_data_source.dart';

class PolyRemoteDataSourceImpl implements PolyRemoteDataSource {
  final http.Client client;

  PolyRemoteDataSourceImpl({@required this.client});
  @override
  Future<bool> addPoly(Poly params) async {
    try {
      var response = await client.post(SERVER_BASE_URI + "Polygone",
          headers: {'Content-Type': 'application/json'},
          body: json.encode(params.toJson()));
      print(json.encode(params.toJson()));
      return response.statusCode == 201;
    } on HttpException {
      throw ServerExeption();
    }
  }

  @override
  Future<List<Poly>> getPoly(String params) async {
    List<Poly> listPoly = new List();
    var response = await client.post(SERVER_BASE_URI + "Polygone/get",
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"id": params}));
    var jsonresponse = json.decode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonarray = jsonresponse;
      print(jsonarray);
      for (Map d in jsonarray) {
        print(Poly.fromJson(d).polygonId);
        listPoly.add(Poly.fromJson(d));
      }
      return listPoly;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<bool> deletePoly(String params) async {
    var response = await client.post(SERVER_BASE_URI + "Polygone/delete",
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"id": params}));
    print(json.encode(params));
    return response.statusCode == 203;
  }
}
