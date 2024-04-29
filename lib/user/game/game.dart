import 'package:flutter/material.dart';
import 'package:online_learning/user/game/T_o_FGame.dart';

import 'package:online_learning/user/game/game1.dart';
import 'package:online_learning/user/game/co_game.dart';

class co_game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Hub'),
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
                  // Navigate to Game Hub page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
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
                          'assets/i_game.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Identify Image', // Your text
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
                    MaterialPageRoute(builder: (context) => CoGane()),
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
                          'assets/s_game.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'count game', // Your text
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
                    MaterialPageRoute(
                        builder: (context) => ImageQuestionScreen2()),
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
                          'assets/t_game.webp', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'T or F', // Your text
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
