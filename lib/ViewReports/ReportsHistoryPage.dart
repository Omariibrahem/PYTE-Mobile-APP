import 'package:flutter/material.dart';

class ReportsHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example session logs
    final List<Map<String, String>> sessionLogs = [
      {
        'date': '2025-01-01 10:00',
        'patient': 'John Doe',
        'summary': 'Excellent performance'
      },
      {
        'date': '2025-01-02 11:00',
        'patient': 'Jane Smith',
        'summary': 'Good performance'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reports & History'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sessionLogs.length,
          itemBuilder: (context, index) {
            final log = sessionLogs[index];
            return Card(
              child: ListTile(
                title: Text('Date & Time: ${log['date']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patient Name: ${log['patient']}'),
                    Text('Performance Summary: ${log['summary']}'),
                    ElevatedButton(
                      onPressed: () {
                        // Export report logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Export Report',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
