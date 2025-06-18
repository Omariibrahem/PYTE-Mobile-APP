import 'package:flutter/material.dart';

class RealTimeMonitoringPage extends StatefulWidget {
  @override
  _RealTimeMonitoringPageState createState() => _RealTimeMonitoringPageState();
}

class _RealTimeMonitoringPageState extends State<RealTimeMonitoringPage> {
  String postureAccuracy = 'Green'; // Example posture accuracy
  int remainingTime = 600; // Example remaining time in seconds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Real-Time Monitoring'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Posture Accuracy Indicator
            Text(
              'Posture Accuracy: $postureAccuracy',
              style: TextStyle(fontSize: 18, color: getPostureColor(postureAccuracy)),
            ),
            SizedBox(height: 20),
            // Session Timer
            Text(
              'Remaining Time: ${formatTime(remainingTime)}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Emergency Alert & Auto-Stop Button
            ElevatedButton(
              onPressed: () {
                // Emergency alert & auto-stop logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Emergency Alert & Auto-Stop',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get color based on posture accuracy
  Color getPostureColor(String postureAccuracy) {
    switch (postureAccuracy) {
      case 'Green':
        return Colors.green;
      case 'Yellow':
        return Colors.yellow;
      case 'Red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Function to format time
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
