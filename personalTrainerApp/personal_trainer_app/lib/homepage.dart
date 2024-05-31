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
            imageUrl: 'https://static.vecteezy.com/system/resources/previews/009/245/053/non_2x/membership-outline-icon-free-vector.jpg',
            onTap: () {
              Navigator.pushNamed(context, '/membership');
            },
          ),
          WorkoutItem(
            text: 'Workout',
            imageUrl: 'https://cdn-icons-png.flaticon.com/512/3860/3860254.png',
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
          WorkoutItem(
            text: 'Profile',
            imageUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
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
  final String imageUrl;
  final VoidCallback onTap;

  WorkoutItem({required this.text, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                    ),
                  ),
                ),
              ),
            ),
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
