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
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: NavigationDrawer(),
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


class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Membership'),
            onTap: () {
              Navigator.pushNamed(context, '/membership');
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Workout'),
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
          ListTile(
            leading: Icon(Icons.monitor),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
