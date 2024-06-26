import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class game2_delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game delete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Game'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/PMSbackground.png'), // Replace 'assets/PMSbackground.png' with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('game2').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<QueryDocumentSnapshot> questions = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> questionData =
                          questions[index].data() as Map<String, dynamic>;
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              questionData['imageUrl'],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    questionData['question'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ...List.generate(
                                    questionData['correctOption'].length,
                                    (optionIndex) => Text(
                                      questionData['correctOption']
                                          [optionIndex],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await _firestore
                                      .collection('game2')
                                      .doc(questions[index].id)
                                      .delete();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
