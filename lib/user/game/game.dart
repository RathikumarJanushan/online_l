import 'package:flutter/material.dart';

import 'package:online_learning/user/game/game1.dart';

class co_game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identify Image Game'),
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
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
              child: Text('count game'),
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
                // Navigate to co_game Hub page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
              child: Text('game3'),
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
                // Navigate to co_game page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
              child: Text('co_game3'),
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
