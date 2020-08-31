import 'dart:convert';

import 'package:CWCFlutter/core/Environment.dart';
import 'package:CWCFlutter/core/Params.dart';
import 'package:CWCFlutter/features/signin/data/dataSource/User_remote_data_source.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSpourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSpourceImpl({@required this.client});
  @override
  Future<User> create_user(UserParams params) async {
    var response = await client.post(SERVER_BASE_URI + 'user/',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params.user.toJson()));
    print(json.encode(SERVER_BASE_URI + 'user/'));
    print(json.encode(params.user.toJson()));
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.body);
    }
  }

  @override
  Future<User> login(LoginParams params) async {
    var response = await client.post(SERVER_BASE_URI + 'user/login',
        headers: {'Content-Type': 'application/json'},
        body:
            json.encode({"email": params.email, "password": params.password}));
    print(json.encode({"email": params.email, "password": params.password}));
    if (response.statusCode == 200) {
      print("nikomek il 9a7ba");
      return User.fromJsonLogin(json.decode(response.body));
    } else {
      print(response.body);
    }
  }
}
