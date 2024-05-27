import 'package:flutter/material.dart';
import 'login.dart';
import 'workout_page.dart';
import 'profile_page.dart';
import 'membership_page.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Trainer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/membership': (context) => MembershipPage(),
        '/workout': (context) => WorkoutPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}