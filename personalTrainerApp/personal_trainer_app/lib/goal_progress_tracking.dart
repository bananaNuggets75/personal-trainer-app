import 'package:flutter/material.dart';

class GoalProgressTracker extends StatefulWidget {
  @override
  _GoalProgressTrackerState createState() => _GoalProgressTrackerState();
}

class _GoalProgressTrackerState extends State<GoalProgressTracker> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal and Progress Tracking'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Goal Setting'),
            Tab(text: 'Session Scheduling'),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          GoalSettingTab(),
          SessionSchedulingTab(),
        ],
      ),
    );
  }
}

class GoalSettingTab extends StatelessWidget {
  final TextEditingController _goalDescriptionController = TextEditingController();
  final TextEditingController _targetDateController = TextEditingController();
  final TextEditingController _progressMetricsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _goalDescriptionController,
            decoration: InputDecoration(labelText: 'Goal Description'),
          ),
          TextField(
            controller: _targetDateController,
            decoration: InputDecoration(labelText: 'Target Date'),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            controller: _progressMetricsController,
            decoration: InputDecoration(labelText: 'Progress Metrics'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: Text('Add Goal'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Goal 1'),
                  subtitle: Text('Progress: 50%'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                    },
                  ),
                ),
                ListTile(
                  title: Text('Goal 2'),
                  subtitle: Text('Progress: 30%'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SessionSchedulingTab extends StatelessWidget {
  final TextEditingController _sessionTypeController = TextEditingController();
  final TextEditingController _coachInstructorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _sessionTypeController,
            decoration: InputDecoration(labelText: 'Session Type'),
          ),
          TextField(
            controller: _coachInstructorController,
            decoration: InputDecoration(labelText: 'Coach/Instructor'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Date'),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            controller: _timeController,
            decoration: InputDecoration(labelText: 'Time'),
            keyboardType: TextInputType.datetime,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: Text('Schedule Session'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Session 1'),
                  subtitle: Text('Date: 2024-06-01 Time: 10:00 AM'),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                    },
                  ),
                ),
                ListTile(
                  title: Text('Session 2'),
                  subtitle: Text('Date: 2024-06-02 Time: 11:00 AM'),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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

