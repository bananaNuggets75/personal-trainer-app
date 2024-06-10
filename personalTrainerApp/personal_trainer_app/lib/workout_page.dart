import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String selectedWorkoutType = 'Cardio';
  double? expectedTime;
  double? calorieBurn;

  // Hypothetical calorie burn rates per minute for each workout
  Map<String, Map<String, double>> workoutCategories = {
    'Cardio': {
      'Running': 10.0,
      'Cycling': 8.0,
      'Jump Rope': 12.0,
    },
    'Chest': {
      'Push Up': 8.0,
      'Bench Press': 9.0,
      'Chest Fly': 7.0,
    },
    'Leg': {
      'Squat': 6.0,
      'Leg Press': 7.0,
      'Lunges': 5.0,
    },
  };

  Map<String, bool> selectedWorkouts = {};

  @override
  void initState() {
    super.initState();
    // Initialize selectedWorkouts with the default workout type
    updateSelectedWorkouts();
  }

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
                Navigator.pop(context);
              },
            );
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Workout Type:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
              value: selectedWorkoutType,
              items: workoutCategories.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedWorkoutType = newValue;
                    updateSelectedWorkouts();
                    calculateCalorieBurn();
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select Workouts:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3, // Adjust this to control the height of the tiles
                children: selectedWorkouts.keys.map((String key) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWorkouts[key] = !selectedWorkouts[key]!;
                        calculateCalorieBurn();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedWorkouts[key]! ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                        border: selectedWorkouts[key]! ? Border.all(color: Colors.blue, width: 2) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fitness_center, size: 30), // Smaller icon size
                          SizedBox(height: 5),
                          Text(key, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0)), // Smaller font size
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Expected Time (minutes):',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Expected Time',
              ),
              onChanged: (value) {
                setState(() {
                  expectedTime = double.tryParse(value);
                  // Recalculate calorie burn when expected time changes
                  if (expectedTime != null) {
                    calculateCalorieBurn();
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Calculated Calorie Burn: ${calorieBurn?.toStringAsFixed(2) ?? "N/A"}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the submit action
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  textStyle: TextStyle(fontSize: 18.0),
                  elevation: 2, // Adjust the elevation as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedWorkouts() {
    selectedWorkouts = Map.fromIterable(
      workoutCategories[selectedWorkoutType]!.keys,
      key: (k) => k,
      value: (v) => false,
    );
  }

  void calculateCalorieBurn() {
    if (expectedTime != null) {
      double totalCalories = 0.0;
      selectedWorkouts.forEach((workout, isSelected) {
        if (isSelected) {
          totalCalories += (workoutCategories[selectedWorkoutType]![workout] ?? 0) * expectedTime!;
        }
      });
      setState(() {
        calorieBurn = totalCalories;
      });
    }
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
