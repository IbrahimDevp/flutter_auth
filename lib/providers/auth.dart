import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _username;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get username {
    if (_username != null) {
      return _username;
    }
    return null;
  }

  Future<void> _authenticate(String username, String password) async {
    var credentials = '$username:$password';
    final url = Uri.parse('http://10.0.2.2:4000/api/v1/auth/login');
    String encoded = base64Encode(utf8.encode(credentials));
    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Basic $encoded'},
      );
      final responseData = json.decode(response.body);
      String thisone = responseData['result'];
      if (thisone.contains('not')) {
        throw HttpException(responseData['result']);
      }
      _token = responseData['result'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String username, String password) async {
    _username = username;
    return _authenticate(username, password);
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
