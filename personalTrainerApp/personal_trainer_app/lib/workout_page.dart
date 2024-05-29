import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String selectedWorkout = 'Push up';
  double? expectedTime;
  double? calorieBurn;

  // Hypothetical calorie burn rates per minute for each workout
  Map<String, double> calorieBurnRates = {
    'Push up': 8.0,
    'Squat': 6.0,
    'Pull up': 10.0,
  };

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
            Text('Select Workout:'),
            DropdownButton<String>(
              value: selectedWorkout,
              items: <String>['Push up', 'Squat', 'Pull up']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedWorkout = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text('Expected Time:'),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Expected Time finished',
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
            Text('Input Calorie burn:'),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter expected calorie burn',
              ),
              onChanged: (value) {
                setState(() {
                  calorieBurn = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text('Calculated Calorie Burn: ${calorieBurn ?? "N/A"}'),
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

  void calculateCalorieBurn() {
    if (expectedTime != null && calorieBurnRates.containsKey(selectedWorkout)) {
      setState(() {
        calorieBurn = expectedTime! * calorieBurnRates[selectedWorkout]!;
      });
    }
  }
}
