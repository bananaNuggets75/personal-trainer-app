import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Trainer'),
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
          Text(
            'Are you ready to transform your body?',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
            child: WorkoutSection(),
          ),
          SizedBox(height: 30),
          SectionGrid(),
        ],
      ),
    );
  }
}

class WorkoutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3860/3860254.png'), // Replace with your workout image URL
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Center(
          child: Text(
            'Workout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SectionGrid extends StatelessWidget {
  final List<Map<String, String>> sections = [
    {
      'title': 'Membership',
      'imageUrl': 'https://static.vecteezy.com/system/resources/previews/009/245/053/non_2x/membership-outline-icon-free-vector.jpg',
      'route': '/membership',
    },
    {
      'title': 'Profile',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'route': '/profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: sections.map((section) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SectionItem(
              title: section['title']!,
              imageUrl: section['imageUrl']!,
              route: section['route']!,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SectionItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String route;

  SectionItem({required this.title, required this.imageUrl, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
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
            leading: Icon(Icons.fitness_center),
            title: Text('Workout'),
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
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

class MembershipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memberships'),
      ),
      body: Center(
        child: Text('Membership Page Content'),
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
      ),
      body: Center(
        child: Text('Workout Page Content'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}
