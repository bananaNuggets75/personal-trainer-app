import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: NavigationDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          WorkoutItem(
            text: 'Membership',
            color: Colors.purple,
            onTap: () {
              Navigator.pushNamed(context, '/membership');
            },
          ),
          WorkoutItem(
            text: 'Workout',
            color: Colors.cyan,
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
          WorkoutItem(
            text: 'Profile',
            color: Colors.purple,
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  WorkoutItem({required this.text, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
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
