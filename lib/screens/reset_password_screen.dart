import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text('Trial ;D'),
            ),
          ],
        ),
      ),
    );
  }
}
