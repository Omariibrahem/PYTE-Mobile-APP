import 'package:flutter/material.dart';
import 'package:MovmentTest/Tools/MyColors.dart';

class StartNewSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Start New Session'),
        backgroundColor: MyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Two icons per row
          mainAxisSpacing: 20.0, // Spacing between rows
          crossAxisSpacing: 20.0, // Spacing between columns
          children: [
            _buildJointButton(
              imagePath: 'assets/images/ankle_icon.png',
              label: 'Ankle',
              onPressed: () {
                Navigator.pushNamed(context, 'AnklePage');
              },
            ),
            _buildJointButton(
              imagePath: 'assets/images/knee_icon.png',
              label: 'Knee',
              onPressed: () {
                Navigator.pushNamed(context, 'KneePage');
              },
            ),
            _buildJointButton(
              imagePath: 'assets/images/hip_icon.png',
              label: 'Hip',
              onPressed: () {
                Navigator.pushNamed(context, 'HipPage');
              },
            ),
            _buildJointButton(
              imagePath: 'assets/images/wrist_icon.png',
              label: 'Wrist',
              onPressed: () {
                Navigator.pushNamed(context, 'WristPage');
              },
            ),
            _buildJointButton(
              imagePath: 'assets/images/elbow_icon.png',
              label: 'Elbow',
              onPressed: () {
                Navigator.pushNamed(context, 'ElbowPage');
              },
            ),
            _buildJointButton(
              imagePath: 'assets/images/shoulder_icon.png', // Custom image path
              label: 'Shoulder',
              onPressed: () {
                Navigator.pushNamed(context, 'ShoulderPage');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to create joint selection buttons with custom images
  Widget _buildJointButton({required String imagePath, required String label, required VoidCallback onPressed}) {
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
            Image.asset(imagePath, height: 60),
            SizedBox(height: 10),
            Text(label, style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
