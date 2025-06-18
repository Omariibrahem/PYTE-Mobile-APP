import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MovmentTest/Services/mqtt_service.dart';
import 'package:MovmentTest/Tools/MyColors.dart';

class ManualControlPage extends StatefulWidget {
  @override
  _ManualControlPageState createState() => _ManualControlPageState();
}

class _ManualControlPageState extends State<ManualControlPage> {
  double speed = 1.0;
  double sensitivity = 1.0;

  @override
  Widget build(BuildContext context) {
    final mqttService = Provider.of<MqttService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Manual Control'),
        backgroundColor:MyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Movement Control',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            // Movement Control Buttons
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: [
                _buildMovementButton(mqttService, Icons.north_west, 'Q'), // Sends 'A' for northwest
                _buildMovementButton(mqttService, Icons.arrow_upward, 'F'), // Sends 'B' for up
                _buildMovementButton(mqttService, Icons.north_east, 'E'), // Sends 'C' for northeast
                _buildMovementButton(mqttService, Icons.arrow_back, 'L'), // Sends 'D' for left
                _buildMovementButton(mqttService, Icons.stop, 'S'), // Sends 'E' for stop
                _buildMovementButton(mqttService, Icons.arrow_forward, 'R'), // Sends 'F' for right
                _buildMovementButton(mqttService, Icons.south_west, 'Z'), // Sends 'G' for southwest
                _buildMovementButton(mqttService, Icons.arrow_downward, 'B'), // Sends 'H' for down
                _buildMovementButton(mqttService, Icons.south_east, 'C'), // Sends 'I' for southeast
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Speed & Sensitivity Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text('Speed', style: TextStyle(color: Colors.black)),
            Slider(
              value: speed,
              min: 0,
              max: 5,
              divisions: 5,
              label: speed.toString(),
              onChanged: (value) {
                setState(() {
                  speed = value;
                });
              },
            ),
            Text('Sensitivity', style: TextStyle(color: Colors.black)),
            Slider(
              value: sensitivity,
              min: 0,
              max: 5,
              divisions: 5,
              label: sensitivity.toString(),
              onChanged: (value) {
                setState(() {
                  sensitivity = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Diagnostics & Troubleshooting',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Diagnostics & troubleshooting logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LoginButtonColor, // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Run Diagnostics',
                style: TextStyle(fontSize: 18, color: MyBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create movement control buttons with icons
  Widget _buildMovementButton(MqttService mqttService, IconData icon, String direction) {
    return ElevatedButton(
      onPressed: () {
        mqttService.controlCar(direction);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Button color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Icon(icon, size: 18, color: MyBlue),
    );
  }
}
