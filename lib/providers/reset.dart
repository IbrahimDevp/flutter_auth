import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/http_exception.dart';

class Reset with ChangeNotifier {
  Future<void> resetPassword(
      String username, String password, String npassword) async {
    try {
      if (username == '' || password == '' || npassword == '') {
        throw HttpException('Fields cannot be empty.');
      } else {
        final url = Uri.parse('http://161.35.99.225:80/api/v1/auth/reset');

        final request = http.Request("PUT", url);
        request.headers
            .addAll(<String, String>{"Content-Type": "application/json"});
        Map data = {
          "username": "$username",
          "opassword": "$password",
          "npassword": "$npassword",
        };
        request.body = json.encode(data);
        print(request.body);
        final response = await request.send();
        final respStr = await response.stream.bytesToString();
        Map valueMap = jsonDecode(respStr);
        print(valueMap['result']['message']);
        if (valueMap['result']['status'] == 0) {
          throw HttpException(valueMap['result']['message']);
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
