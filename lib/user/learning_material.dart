import 'package:flutter/material.dart';
import 'package:online_learning/user/Assessment/Assessment_m.dart';
import 'package:online_learning/user/video.dart';

import 'package:online_learning/user/game/game.dart';

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
                  // Navigate to Game Hub page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPage()),
                  );
                },
                child: Container(
                  width: 200, // Adjust width as needed
                  height:
                      150, // Adjust height as needed to accommodate both image and text
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Add border radius for rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Add shadow color
                        spreadRadius: 5, // Add spread radius
                        blurRadius: 7, // Add blur radius
                        offset: Offset(0, 3), // Add offset
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Match the container's border radius
                        child: Image.asset(
                          'assets/Learning.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Learning Video', // Your text
                        style: TextStyle(
                          fontSize: 20, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Add font weight if needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Game Hub page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Assessment()),
                  );
                },
                child: Container(
                  width: 200, // Adjust width as needed
                  height:
                      150, // Adjust height as needed to accommodate both image and text
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Add border radius for rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Add shadow color
                        spreadRadius: 5, // Add spread radius
                        blurRadius: 7, // Add blur radius
                        offset: Offset(0, 3), // Add offset
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Match the container's border radius
                        child: Image.asset(
                          'assets/assessment.avif', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Assessment', // Your text
                        style: TextStyle(
                          fontSize: 20, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Add font weight if needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Game Hub page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => co_game()),
                  );
                },
                child: Container(
                  width: 200, // Adjust width as needed
                  height:
                      150, // Adjust height as needed to accommodate both image and text
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Add border radius for rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Add shadow color
                        spreadRadius: 5, // Add spread radius
                        blurRadius: 7, // Add blur radius
                        offset: Offset(0, 3), // Add offset
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Match the container's border radius
                        child: Image.asset(
                          'assets/game.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Game Hub', // Your text
                        style: TextStyle(
                          fontSize: 20, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Add font weight if needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
