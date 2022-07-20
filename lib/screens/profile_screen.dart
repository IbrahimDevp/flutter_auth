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
            Profile(
              imageUrl:
                  "https://avatars.githubusercontent.com/u/26470894?s=400&u=3c7627f74e2098059bbe2ab24af167e2adbe4383&v=4",
              name: "Ibrahim Alkhwaja",
              website: "gmail.com",
              designation: "COOP Student",
              email: "ibrahim.alkhwaja@gmail.com",
              phone_number: "0551177414",
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Delete Account'),
                onPressed: () {
                  print('hello');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  print('hello');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
