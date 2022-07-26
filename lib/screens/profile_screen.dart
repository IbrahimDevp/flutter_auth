import '../providers/auth.dart';
import '../providers/info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    void _delete() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Deleting Account!'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                int count = 0;
                Provider.of<Info>(context, listen: false).deleteAccount();
                Navigator.of(ctx).pop();
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: Text(
                'DELETE ACCOUNT!',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    final productsData = Provider.of<Info>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: productsData.getUserInfo(),
        builder: (_, __) => Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
              Text(productsData.userInfo.fname),
              Text(productsData.userInfo.lname),
              Text(productsData.userInfo.email),
              Text(productsData.userInfo.company),
              Text(productsData.userInfo.gender),
              Text(productsData.userInfo.uname),
              Container(
                child: ElevatedButton(
                  child: const Text('Delete Account'),
                  onPressed: () {
                    _delete();
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
              ),
              // Consumer(
              //   builder: (ctx, orderData, child) => ListView.builder(
              //     itemCount: productsData.colleaguesInfo.length,
              //     itemBuilder: (ctx, i) => Text(productsData.colleaguesInfo[i]),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
