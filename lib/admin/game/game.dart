import 'package:flutter/material.dart';
import 'package:online_learning/admin/game_add/h_game.dart';
import 'package:online_learning/admin/ass_delete/del_ass.dart';

class g_add_del extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add & delete'),
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
                  MaterialPageRoute(builder: (context) => game()),
                );
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 246, 6),
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
                  MaterialPageRoute(builder: (context) => Assessment_de()),
                );
              },
              child: Text('view & Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 237, 114, 7),
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
