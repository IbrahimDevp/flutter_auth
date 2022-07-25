import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class User {
  String fname;
  String lname;
  String email;
  String company;
  String gender;
  String uname;
  User({
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.company,
    @required this.gender,
    @required this.uname,
  });
}

class Info with ChangeNotifier {
  final String token;
  final String username;
  Info(this.token, this.username);
  var _youraccount = new User(
    fname: '',
    lname: '',
    email: '',
    company: '',
    gender: '',
    uname: '',
  );

  User get userInfo {
    return _youraccount;
  }

  Future<void> getUserInfo() async {
    final url = Uri.parse('http://10.0.2.2:4000/api/v1/users');
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: '$token',
      },
    );

    // final responseJson = (jsonDecode(response.body))['result']
    //     .indexWhere((e) => e['username'] == username);
    // print(responseJson);
    final data = jsonDecode(response.body)['result'];
    final index = data.indexWhere((element) => element['username'] == username);
    final userObject = data[index];
    final userData = User(
      fname: userObject['first_name'],
      lname: userObject['last_name'],
      email: userObject['email'],
      company: userObject['company'],
      gender: userObject['gender'],
      uname: username,
    );
    _youraccount = userData;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    final url = Uri.parse('http://10.0.2.2:4000/api/v1/users/remove');
    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: '$token',
    });
    Map data = {"username": "$username"};
    request.body = json.encode(data);
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
  }
}
