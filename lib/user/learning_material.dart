import 'package:flutter/material.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/user/Assessment/Assessment_m.dart';
import 'package:online_learning/user/report.dart';
import 'package:online_learning/user/video.dart';
import 'package:online_learning/user/game/game.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_learning/widgets/button.dart'; // Import FirebaseAuth

class LearningMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Learning Material',
                textAlign: TextAlign.center,
              ),
            ),
            CustomButton(
              label: "Sign Out",
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/PMSbackground.png"), // Background image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome ${FirebaseAuth.instance.currentUser?.email ?? 'User'}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to VideoPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideosPage()),
                          );
                        },
                        child: buildLearningMaterialItem(
                          'assets/Learning.jpg',
                          'Learning Video',
                          context,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Assessment
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Assessment()),
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
                          // Navigate to Game Hub
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => co_game()),
                          );
                        },
                        child: buildLearningMaterialItem(
                          'assets/game.jpg',
                          'Game Hub',
                          context,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Report
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Marks()),
                          );
                        },
                        child: buildLearningMaterialItem(
                          'assets/report.jpeg',
                          'Report',
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLearningMaterialItem(String imagePath, String title, BuildContext context) {
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
