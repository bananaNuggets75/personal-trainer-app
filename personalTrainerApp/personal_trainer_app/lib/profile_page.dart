import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<String> activities = [
    'Push Up - 30 reps',
    'Squat - 50 reps',
    'Running - 5 km',
  ];

  List<String> goals = [
    'Run 10 km in a week',
    'Do 100 push-ups in one session',
    'Squat 200 times in a month',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // User profile image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Joni Jupiter', // User name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fitness Enthusiast', // User tagline
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // User activities section
            Text(
              'Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ...activities.map((activity) => ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text(activity),
            )),
            SizedBox(height: 20),
            // User goals section
            Text(
              'Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ...goals.map((goal) => ListTile(
              leading: Icon(Icons.flag),
              title: Text(goal),
            )),
          ],
        ),
      ),
    );
  }
}
