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

    final loggedinUser = Provider.of<Info>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: loggedinUser.getUserInfo(),
        builder: (_, __) => Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
              Text(
                'Profile Details:',
                style: TextStyle(fontSize: 20),
              ),
              Text(loggedinUser.userInfo.fname),
              Text(loggedinUser.userInfo.lname),
              Text(loggedinUser.userInfo.email),
              Text(loggedinUser.userInfo.company),
              Text(loggedinUser.userInfo.gender),
              Text(loggedinUser.userInfo.uname),
              Divider(),
              Text(
                'People who also work at ' + loggedinUser.userInfo.company,
                style: TextStyle(fontSize: 20),
              ),
              if (loggedinUser.colleaguesInfo.length.toInt() == 1)
                Text(
                  'No colleagues with ' + loggedinUser.userInfo.fname,
                ),
              for (int i = 0;
                  i < (loggedinUser.colleaguesInfo.length.toInt());
                  i++)
                if (loggedinUser.userInfo.fname !=
                    loggedinUser.colleaguesInfo[i].toString())
                  Text(
                    loggedinUser.colleaguesInfo[i].toString(),
                  ),
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
