import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/http_exception.dart';

class Reset with ChangeNotifier {
  Future<void> resetPassword(
      String username, String password, String npassword) async {
    var url = Uri.parse('http://10.0.2.2:4000/api/v1/users');
    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjYyYzFkYjM4NWYyMzQ4MDNjMGNjNDUwZSIsImlkIjoyNTA1NDUyLCJmaXJzdF9uYW1lIjoiV2hpdGJ5IiwibGFzdF9uYW1lIjoiUmlzYnJvdWdoIiwiZW1haWwiOiJ3cmlzYnJvdWdoM0BtZWRpYWZpcmUuY29tIiwidXNlcm5hbWUiOiJ3cmlzYnJvdWdoMyIsImNvbXBhbnkiOiJUb3BpY3dhcmUiLCJwYXNzd29yZCI6InlPMzBqYWZCNlNzIiwiZ2VuZGVyIjoiTWFsZSJ9LCJpYXQiOjE2NTY4NzI5MDl9.hNqC4qE2gVb_Xs3RZmi6wiDpzqeimTuVaTyBAZ0cD_M',
        },
      );
      if (username == '' || password == '' || npassword == '') {
        throw HttpException('empty');
      }
      final data = jsonDecode(response.body)['result'];
      final index =
          data.indexWhere((element) => element['username'] == username);
      if (index == -1) {
        throw HttpException('Username does not exist.');
      }
      final userObject = data[index];
      if (userObject['password'] != password) {
        throw HttpException('Password');
      } else {
        final url = Uri.parse('http://10.0.2.2:4000/api/v1/users/reset');

        final request = http.Request("PUT", url);
        request.headers.addAll(<String, String>{
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjYyYzFkYjM4NWYyMzQ4MDNjMGNjNDUwZSIsImlkIjoyNTA1NDUyLCJmaXJzdF9uYW1lIjoiV2hpdGJ5IiwibGFzdF9uYW1lIjoiUmlzYnJvdWdoIiwiZW1haWwiOiJ3cmlzYnJvdWdoM0BtZWRpYWZpcmUuY29tIiwidXNlcm5hbWUiOiJ3cmlzYnJvdWdoMyIsImNvbXBhbnkiOiJUb3BpY3dhcmUiLCJwYXNzd29yZCI6InlPMzBqYWZCNlNzIiwiZ2VuZGVyIjoiTWFsZSJ9LCJpYXQiOjE2NTY4NzI5MDl9.hNqC4qE2gVb_Xs3RZmi6wiDpzqeimTuVaTyBAZ0cD_M',
        });
        Map data = {
          "username": "$username",
          "npassword": "$npassword",
        };
        request.body = json.encode(data);
        final response = await request.send();
        final respStr = await response.stream.bytesToString();
        print(respStr);
        if (respStr.contains('similar')) {
          throw HttpException('similar');
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
