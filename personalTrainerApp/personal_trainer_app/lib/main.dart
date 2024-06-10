import 'package:flutter/material.dart';
import 'login.dart';
import 'package:personal_trainer_app/homepage.dart' as homepage;
import 'package:personal_trainer_app/membership_page.dart' as membership;
import 'package:personal_trainer_app/workout_page.dart' as workout;
import 'package:personal_trainer_app/profile_page.dart' as profile;
import 'package:personal_trainer_app/goal_progress_tracking.dart' as goalProgress;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Trainer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => homepage.HomePage(),
        '/membership': (context) => membership.MembershipPage(),
        '/workout': (context) => workout.WorkoutPage(),
        '/profile': (context) => profile.ProfilePage(),
        '/goalProgress': (context) => goalProgress.GoalProgressTracker(),
      },
    );
  }
}
