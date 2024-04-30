import 'package:flutter/material.dart';
import 'package:online_learning/admin/ass/add_del.dart';
import 'package:online_learning/admin/add_video.dart';
import 'package:online_learning/admin/game/game.dart';

class LearningMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Material'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/PMSbackground.png"), // Background image asset path
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
                    MaterialPageRoute(builder: (context) => VideoPage()),
                  );
                },
                child: buildLearningMaterialItem(
                  'assets/Learning.jpg',
                  'Training Video',
                  context,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Assessment
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => add_del()),
                  );
                },
                child: buildLearningMaterialItem(
                  'assets/assessment.avif',
                  'Assessment',
                  context,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Report
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => g_add_del()),
                  );
                },
                child: buildLearningMaterialItem(
                  'assets/game.jpg',
                  'Game Hub',
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
