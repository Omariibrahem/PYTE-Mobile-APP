import 'package:MovmentTest/Tools/MyColors.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int batteryPercentage = 90; // Example percentage
  bool isConnected = true; // Example connectivity status
  String operationalStatus = "Active"; // Example operational status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Add Padding to move content down
              Padding(
                padding: const EdgeInsets.only(top: 50.0), // Adjust the top padding as needed
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/hospital_logo.png', // Path to the hospital logo
                      height: 90,
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Text(
                        'MR Pyte                      is on service', // Therapist’s name
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: MyBlue, // The color of the line
                height: 20, // The height of the divider, includes the line itself and any spacing around it
                thickness: 2, // The thickness of the line
                indent: 10, // The left inset
                endIndent: 10, // The right inset
              ),
              // Live Robot Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.battery_full, color: getBatteryColor(), size: 30),
                      Text('Battery: $batteryPercentage%', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(isConnected ? Icons.wifi : Icons.wifi_off, color: isConnected ? Colors.green : Colors.red, size: 30),
                      Text('${isConnected ? "Connected" : "Disconnected"}', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.yellow, size: 30),
                      Text('$operationalStatus', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ],
              ),
              Divider(
                color: MyBlue, // The color of the line
                height: 20, // The height of the divider, includes the line itself and any spacing around it
                thickness: 2, // The thickness of the line
                indent: 10, // The left inset
                endIndent: 10, // The right inset
              ),

              SizedBox(height: 40),
              // Quick Actions as Custom Images with Labels
              GridView.count(
                crossAxisCount: 2, // Two icons per row
                mainAxisSpacing: 20.0, // Spacing between rows
                crossAxisSpacing: 20.0, // Spacing between columns
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                children: [
                  _buildQuickActionButton(
                    imagePath: 'assets/images/start_session_icon.png', // Custom image path
                    label: 'Start New Session',
                    onPressed: () {
                      Navigator.pushNamed(context, 'StartNewSessionPage');
                    },
                  ),
                  _buildQuickActionButton(
                    imagePath: 'assets/images/view_reports_icon.png', // Custom image path
                    label: 'View Reports',
                    onPressed: () {
                      Navigator.pushNamed(context, 'ViewReportsPage');
                    },
                  ),
                  _buildQuickActionButton(
                    imagePath: 'assets/images/manual_control_icon.png', // Custom image path
                    label: 'Manual Control',
                    onPressed: () {
                      Navigator.pushNamed(context, 'ManualControlPage');
                    },
                  ),
                  _buildQuickActionButton(
                    imagePath: 'assets/images/patients_icon.png', // Custom image path
                    label: 'Patients',
                    onPressed: () {
                      Navigator.pushNamed(context, 'PatientsPage');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create quick action buttons with custom images
  Widget _buildQuickActionButton({required String imagePath, required String label, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100),
            SizedBox(height: 10),
            Text(label, style: TextStyle(
                color: Colors.black,
                fontSize: 20)),
          ],
        ),
      ),
    );
  }

  // Function to get battery color based on percentage
  Color getBatteryColor() {
    if (batteryPercentage > 80) return Colors.green;
    if (batteryPercentage > 30) return Colors.yellow;
    return Colors.red;
  }
}
