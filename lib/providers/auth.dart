import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String username, String password) async {
    var credentials = '$username:$password';
    final url = Uri.parse('http://10.0.2.2:4000/api/v1/auth/login');
    String encoded = base64Encode(utf8.encode(credentials));
    final response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Basic $encoded'},
    );
    final responseData = json.decode(response.body);
    _token = responseData['result'];
    print(_token);
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    return _authenticate(username, password);
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
