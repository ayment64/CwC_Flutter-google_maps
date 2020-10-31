class Poly {
  String sId;
  List<Points> points;
  int color;
  int polygonId;
  String ownerName;
  String ownerLastName;
  String ownerPhoneNumber;
  String ownerAdress;
  int areaOfTerrain;
  String areaOfTerrainUnit;
  String user;
  String type;
  int iV;

  Poly(
      {this.sId,
      this.points,
      this.color,
      this.polygonId,
      this.ownerName,
      this.ownerLastName,
      this.ownerPhoneNumber,
      this.ownerAdress,
      this.areaOfTerrain,
      this.areaOfTerrainUnit,
      this.user,
      this.type,
      this.iV});

  Poly.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['points'] != null) {
      points = new List<Points>();
      json['points'].forEach((v) {
        points.add(new Points.fromJson(v));
      });
    }
    color = json['Color'];
    polygonId = json['polygonId'];
    ownerName = json['owner_name'];
    ownerLastName = json['owner_last_name'];
    ownerPhoneNumber = json['owner_phone_number'];
    ownerAdress = json['owner_adress'];
    areaOfTerrain = json['area_of_terrain'];
    areaOfTerrainUnit = json['area_of_terrain_unit'];
    user = json['user'];
    type = json['type'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.points != null) {
      data['points'] = this.points.map((v) => v.toJson()).toList();
    }
    data['Color'] = this.color;
    data['polygonId'] = this.polygonId;
    data['owner_name'] = this.ownerName;
    data['owner_last_name'] = this.ownerLastName;
    data['owner_phone_number'] = this.ownerPhoneNumber;
    data['owner_adress'] = this.ownerAdress;
    data['area_of_terrain'] = this.areaOfTerrain;
    data['area_of_terrain_unit'] = this.areaOfTerrainUnit;
    data['user'] = this.user;
    data['type'] = this.type;
    data['__v'] = this.iV;
    return data;
  }
}

class Points {
  Point point;
  Null nId;

  Points({this.point, this.nId});

  Points.fromJson(Map<String, dynamic> json) {
    point = json['point'] != null ? new Point.fromJson(json['point']) : null;
    nId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.point != null) {
      data['point'] = this.point.toJson();
    }
    data['_id'] = this.nId;
    return data;
  }
}

class Point {
  double long;
  double lat;

  Point({this.long, this.lat});

  Point.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['lat'] = this.lat;
    return data;
  }
}
