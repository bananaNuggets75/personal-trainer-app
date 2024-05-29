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
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Workout Type:'),
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
            Text('Select Workouts:'),
            Expanded(
              child: ListView(
                children: selectedWorkouts.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: selectedWorkouts[key],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedWorkouts[key] = value ?? false;
                        calculateCalorieBurn();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Expected Time (minutes):'),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text('Calculated Calorie Burn: ${calorieBurn?.toStringAsFixed(2) ?? "N/A"}'),
            ElevatedButton(
              onPressed: () {
                // Handle the submit action
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                elevation: 2, // Adjust the elevation as needed
              ),
            )
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
