import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SymptomTracker(),
    );
  }
}

class SymptomTracker extends StatefulWidget {
  @override
  _SymptomTrackerState createState() => _SymptomTrackerState();
}

class _SymptomTrackerState extends State<SymptomTracker> {
  List<Map<String, dynamic>> _symptomHistory = [];
  Map<String, dynamic> _currentSymptom = {};

  void _submitSymptoms() {
    setState(() {
      _currentSymptom = {
        'painLevel': _painController.text,
        'fatigueLevel': _fatigueController.text,
        'mood': _moodController.text,
        'timestamp': DateTime.now(),
      };
      _symptomHistory.add(Map.from(_currentSymptom));
      _painController.clear();
      _fatigueController.clear();
      _moodController.clear();
    });
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Symptom History'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _symptomHistory.map((symptom) {
                return ListTile(
                  title: Text(
                      'Pain: ${symptom['painLevel']}, Fatigue: ${symptom['fatigueLevel']}, Mood: ${symptom['mood']}'),
                  subtitle: Text(
                      'Date: ${symptom['timestamp'].toString().substring(0, 16)}'),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _painController = TextEditingController();
  final TextEditingController _fatigueController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _painController,
              decoration: InputDecoration(labelText: 'Pain level'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _fatigueController,
              decoration: InputDecoration(labelText: 'Fatigue level'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _moodController,
              decoration: InputDecoration(labelText: 'Mood'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitSymptoms,
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _showHistory,
              child: Text('Show History'),
            ),
          ],
        ),
      ),
    );
  }
}
