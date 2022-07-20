import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import './screens/reset_password_screen.dart';
import './screens//profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Color.fromARGB(255, 209, 157, 68),
        ),
        home: LoginScreen(),
        routes: {
          ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
        });
  }
}
