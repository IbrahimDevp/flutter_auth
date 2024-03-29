import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import './screens/reset_password_screen.dart';
import './screens/profile_screen.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/info.dart';
import './providers/reset.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Color pColor = Color.fromARGB(255, 209, 157, 68);
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Info>(
            update: (ctx, auth, prev) => Info(auth.token, auth.username)),
        ChangeNotifierProvider.value(
          value: Reset(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.brown,
            accentColor: Color.fromARGB(255, 209, 157, 68),
          ),
          home: auth.isAuth ? ProfileScreen() : LoginScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
          },
        ),
      ),
    );
  }
}
