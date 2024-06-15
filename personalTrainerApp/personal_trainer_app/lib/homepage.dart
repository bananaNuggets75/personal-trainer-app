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
              icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.teal,
      ),
      drawer: NavigationDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Are you ready to transform your body?',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.teal),
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
          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3860/3860254.png'),
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
    {
      'title': 'Goal and Progress',
      'imageUrl': 'https://cdn.iconscout.com/icon/premium/png-256-thumb/goal-8738695-7088930.png',
      'route': '/goalProgress',
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
              color: Colors.teal,
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
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
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('Goal and Progress'),
            onTap: () {
              Navigator.pushNamed(context, '/goalProgress');
            },
          ),
        ],
      ),
    );
  }
}
