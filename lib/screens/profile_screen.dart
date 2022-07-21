import '../providers/auth.dart';
import '../providers/info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
            ),
            Container(
              child: Profile(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909__340.png",
                name: "Ibrahim Alkhwaja",
                website: "gmail.com",
                designation: "COOP Student",
                email: "ibrahim.alkhwaja@gmail.com",
                phone_number: "0551177414",
              ),
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Delete Account'),
                onPressed: () {
                  Provider.of<Info>(context, listen: false).getUserInfo();
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
          ],
        ),
      ),
    );
  }
}
