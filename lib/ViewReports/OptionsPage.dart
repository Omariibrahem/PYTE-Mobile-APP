import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'Tools/MyColors.dart';
import 'Services/FirebaseServices.dart';
import 'Services/mqtt_service.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int batteryPercentage = 90;
  String operationalStatus = "Active";

  @override
  Widget build(BuildContext context) {
    final mqttService = Provider.of<MqttService>(context);
    bool isConnected = mqttService.isConnected;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyBlue,
        title: Text('                     Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final service = GetIt.instance<FirebaseService>();
              await service.logoutUser();
              SystemNavigator.pop(); // ❌ Closes the app
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: [
                Image.asset(
                  'assets/images/hospital_logo.png',
                  height: 90,
                ),
                SizedBox(width: 30),
                Expanded(
                  child: Text(
                    'MR Pyte is on service',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(color: MyBlue, height: 20, thickness: 2, indent: 10, endIndent: 10),

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
                    Text(isConnected ? "Connected" : "Disconnected", style: TextStyle(color: Colors.black)),
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

            Divider(color: MyBlue, height: 20, thickness: 2, indent: 10, endIndent: 10),
            SizedBox(height: 40),

            // Quick Actions
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildQuickActionButton(
                  imagePath: 'assets/images/start_session_icon.png',
                  label: 'Start New Session',
                  onPressed: () {
                    Navigator.pushNamed(context, 'StartNewSessionPage');
                  },
                ),
                _buildQuickActionButton(
                  imagePath: 'assets/images/view_reports_icon.png',
                  label: 'View Reports',
                  onPressed: () {
                    Navigator.pushNamed(context, 'ViewReportsPage');
                  },
                ),
                _buildQuickActionButton(
                  imagePath: 'assets/images/manual_control_icon.png',
                  label: 'Manual Control',
                  onPressed: () {
                    Navigator.pushNamed(context, 'ManualControlPage');
                  },
                ),
                _buildQuickActionButton(
                  imagePath: 'assets/images/patients_icon.png',
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
    );
  }

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
            Text(label, style: TextStyle(color: Colors.black, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Color getBatteryColor() {
    if (batteryPercentage > 80) return Colors.green;
    if (batteryPercentage > 30) return Colors.yellow;
    return Colors.red;
  }
}
