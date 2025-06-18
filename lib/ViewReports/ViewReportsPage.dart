import 'package:MovmentTest/Tools/MyColors.dart';
import 'package:flutter/material.dart';

class ViewReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('View Reports'),
        backgroundColor: MyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-Time Monitoring Button
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'RealTimeMonitoringPage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LoginButtonColor, // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Real-Time Monitoring',
                style: TextStyle(fontSize: 18, color: MyBlue),
              ),
            ),
            SizedBox(height: 50),
            // Reports & History Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'ReportsHistoryPage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LoginButtonColor, // Button color
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Reports & History',
                style: TextStyle(fontSize: 18, color: MyBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
