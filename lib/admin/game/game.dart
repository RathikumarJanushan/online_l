import 'package:flutter/material.dart';
import 'package:online_learning/admin/game/ass_delete/del_game.dart';
import 'package:online_learning/admin/game_add/h_game.dart';

class g_add_del extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add & delete'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/PMSbackground.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to Report
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => game()),
                  );
                },
                child: buildLearningMaterialItem(
                  'assets/add.png',
                  'Add',
                  context,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Report
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => game_de()),
                  );
                },
                child: buildLearningMaterialItem(
                  'assets/delete.jpg',
                  'view & Delete',
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLearningMaterialItem(
      String imagePath, String title, BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 200,
              height: 100,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
