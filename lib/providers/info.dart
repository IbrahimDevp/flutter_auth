import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Info with ChangeNotifier {
  final String token;
  Info(this.token);

  Future<void> getUserInfo() async {
    final url = Uri.parse('http://10.0.2.2:4000/api/v1/users');

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    final responseJson = jsonDecode(response.body);
    print(responseJson);
  }
}
