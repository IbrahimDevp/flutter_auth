import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reset.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'username': '',
    'password': '',
    'npassword': '',
  };

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
              child: const Text('Reset your password please:'),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _authData['username'] = value;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Old Password',
                      ),
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password  ',
                      ),
                      onSaved: (value) {
                        _authData['npassword'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Reset Password'),
                onPressed: () {
                  _submit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    _formKey.currentState.save();

    await Provider.of<Reset>(context, listen: false).resetPassword(
        _authData['username'], _authData['password'], _authData['npassword']);
  }
}
