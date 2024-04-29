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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/PMSbackground.png'), // Path to your background image asset
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
                    MaterialPageRoute(
                        builder: (context) => assessmentScreen1()),
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
                          'assets/assessment1.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Assessments1', // Your text
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
                        builder: (context) => AssessmentScreen2()),
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
                          'assets/assessment1.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Assessments2', // Your text
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
                        builder: (context) => assessmentScreen3()),
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
                          'assets/assessment1.jpg', // Path to your game hub icon asset
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire container
                          width: 200, // Adjust width as needed
                          height: 100, // Adjust height as needed
                        ),
                      ),
                      SizedBox(
                          height: 10), // Add spacing between image and text
                      Text(
                        'Assessments3', // Your text
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
              // Add your other GestureDetector widgets here
            ],
          ),
        ),
      ),
    );
  }
}
