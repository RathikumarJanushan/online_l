import 'package:flutter/material.dart';
import 'package:online_learning/admin/ass_delete/Assessment1_delete.dart';
import 'package:online_learning/admin/ass_delete/Assessment2_delete.dart';
import 'package:online_learning/admin/ass_delete/Assessment3_delete.dart';

class Assessment_de extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
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
                  MaterialPageRoute(builder: (context) => assessment1_delete()),
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
                  MaterialPageRoute(builder: (context) => assessment2_delete()),
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
                // Navigate to Assessment_de page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => assessment3_delete()),
                );
              },
              child: Text('Assessment_de3'),
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
