import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Info with ChangeNotifier {
  final String token;
  final String username;
  Info(this.token, this.username);
  Future<void> getUserInfo() async {
    final Map<String, String> queryParameters = {
      'username': username,
    };

    final url = Uri.http('10.0.2.2:4000', '/api/v1/users', queryParameters);
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    final responseJson = jsonDecode(response.body);
    final index = responseJson['result']
        .indexWhere((element) => element['username'] == username);
    final fullUserData = responseJson['result'][index];
    Map<String, String> UserData = {
      'first_name': fullUserData['first_name'],
      'last_name': fullUserData['last_name'],
      'email': fullUserData['email'],
      'company': fullUserData['company'],
      'gender': fullUserData['gender'],
    };
    print(UserData);
  }
}
