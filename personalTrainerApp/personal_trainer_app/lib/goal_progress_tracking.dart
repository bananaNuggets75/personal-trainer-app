import 'package:flutter/material.dart';
import 'database.dart';

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
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
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

class GoalSettingTab extends StatefulWidget {
  @override
  _GoalSettingTabState createState() => _GoalSettingTabState();
}

class _GoalSettingTabState extends State<GoalSettingTab> {
  final TextEditingController _goalDescriptionController = TextEditingController();
  final TextEditingController _targetDateController = TextEditingController();
  final TextEditingController _progressMetricsController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

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
            onPressed: () async {
              Map<String, dynamic> row = {
                'description': _goalDescriptionController.text,
                'targetDate': _targetDateController.text,
                'progressMetrics': _progressMetricsController.text,
              };
              await _dbHelper.insertGoal(row);
              setState(() {});
            },
            child: Text('Add Goal'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _dbHelper.queryAllGoals(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.map((goal) {
                    return ListTile(
                      title: Text(goal['description']),
                      subtitle: Text('Progress: ${goal['progressMetrics']}%'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Edit Goal Logic Here
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SessionSchedulingTab extends StatefulWidget {
  @override
  _SessionSchedulingTabState createState() => _SessionSchedulingTabState();
}

class _SessionSchedulingTabState extends State<SessionSchedulingTab> {
  final TextEditingController _sessionTypeController = TextEditingController();
  final TextEditingController _coachInstructorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

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
            onPressed: () async {
              Map<String, dynamic> row = {
                'sessionType': _sessionTypeController.text,
                'coachInstructor': _coachInstructorController.text,
                'date': _dateController.text,
                'time': _timeController.text,
              };
              await _dbHelper.insertSession(row);
              setState(() {});
            },
            child: Text('Schedule Session'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _dbHelper.queryAllSessions(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.map((session) {
                    return ListTile(
                      title: Text(session['sessionType']),
                      subtitle: Text('Date: ${session['date']} Time: ${session['time']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () async {
                          await _dbHelper.deleteSession(session['id']);
                          setState(() {});
                        },
                      ),
                    );
                  }).toList(),
                );
              },
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
