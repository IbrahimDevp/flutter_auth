import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/reset.dart';
import '../models/http_exception.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
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
                    if (_isLoading) CircularProgressIndicator(),
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

    bool _condition = false;
    setState(() {
      if (!_formKey.currentState.validate()) {
        // Invalid!
        return;
      }
      _isLoading = true;
    });
    try {
      await Provider.of<Reset>(context, listen: false).resetPassword(
          _authData['username'], _authData['password'], _authData['npassword']);
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _condition = true;
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not update password. Please try again later.';
      _showErrorDialog(errorMessage);
      _condition = true;
    }
    if (_condition == false) {
      _success();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reset Password Error!'),
        content: Text(message),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); //Close the pop window message.
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  void _success() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Great!'),
        content: Text('You password has been reset.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              child: Text('Go to Login'))
        ],
      ),
    );
  }
}
