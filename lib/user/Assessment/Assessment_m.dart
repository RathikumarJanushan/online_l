import 'package:flutter/material.dart';
import 'package:online_learning/user/Assessment/Assessment1.dart';
import 'package:online_learning/user/Assessment/Assessment2.dart';
import 'package:online_learning/user/Assessment/Assessment3.dart';

class Assessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Training Video page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => assessmentScreen1()),
                );
              },
              child: Text('Assessment1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 235, 235),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Game Hub page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssessmentScreen2()),
                );
              },
              child: Text('Assessment2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Assessment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => assessmentScreen3()),
                );
              },
              child: Text('Assessment3'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 2, 250, 212),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrainingVideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Video'),
      ),
      body: Center(
        child: Text('This is the Training Video page'),
      ),
    );
  }
}
