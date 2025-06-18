import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        backgroundColor: Colors.black12,
      ),
      body: Center(
        child: Text(
          'Patients Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
