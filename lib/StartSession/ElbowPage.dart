import 'package:flutter/material.dart';
import 'package:MovmentTest/Tools/MyColors.dart';

class ElbowPage extends StatefulWidget {
  @override
  _ElbowPageState createState() => _ElbowPageState();
}

class _ElbowPageState extends State<ElbowPage> {
  String selectedExercise = '';
  int duration = 10;
  int repetitions = 3;
  double rangeOfMotion = 0.0;
  String intensity = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Elbow Exercises'),
        backgroundColor: LoginButtonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Exercise Selection
            DropdownButton<String>(
              value: selectedExercise.isEmpty ? null : selectedExercise,
              hint: Text('Select Exercise'),
              items: <String>[
                'Flexion',
                'Extension'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedExercise = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            // Parameter Adjustments
            TextField(
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  duration = int.parse(value);
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Repetitions (sets)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  repetitions = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text('Range of motion', style: TextStyle(color: Colors.black)),
            Slider(
              value: rangeOfMotion,
              min: 0,
              max: 100,
              divisions: 100,
              label: 'Range of Motion',
              onChanged: (value) {
                setState(() {
                  rangeOfMotion = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Intensity', style: TextStyle(color: Colors.black)),
            DropdownButton<String>(
              value: intensity,
              items: <String>['Light', 'Moderate', 'Strong'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  intensity = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            // Start Session Button
            ElevatedButton(
              onPressed: selectedExercise.isNotEmpty
                  && duration > 0
                  && repetitions > 0
                  && rangeOfMotion > 0
                  && intensity.isNotEmpty
                  ? () {
                // Start session logic
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: LoginButtonColor, // Background color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Start Session',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
