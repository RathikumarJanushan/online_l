import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _images = [];
  int _correctAnswersCount = 0;
  late List<int?> _selectedOptions;

  int _currentQuestionIndex = 0;

  _GameState() {
    _selectedOptions = [];
  }

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  void _fetchImages() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('images').get();
    setState(() {
      _images = querySnapshot.docs.map((doc) => doc.data()).toList();
      _selectedOptions = List.generate(_images.length, (_) => null);
    });
  }

  void _submitAnswer(
      int optionIndex, String correctOption, BuildContext context) async {
    if (_selectedOptions[_currentQuestionIndex] != null) {
      return; // Answer already selected
    }

    setState(() {
      _selectedOptions[_currentQuestionIndex] = optionIndex;
    });

    if (optionIndex ==
        _images[_currentQuestionIndex]['options'].indexOf(correctOption)) {
      setState(() {
        _correctAnswersCount += 5; // Increase score by 5 for correct answer
      });

      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Perform the Firestore transaction
      await _updateAssessmentMarks(userId, _correctAnswersCount);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateAssessmentMarks(
      String userId, int _correctAnswersCount) async {
    // Get the Firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Get the document reference
    final docRef = _firestore.collection('Report').doc(userId);

    // Start a Firestore transaction
    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(docRef);

      if (!doc.exists) {
        // If the document doesn't exist, create it with Assessment1 only
        transaction.set(docRef, {'game1': _correctAnswersCount});
      } else {
        // If the document exists, update Assessment1 only
        final currentData = doc.data()!;
        final currentAssessment1 = currentData['Assessment1'] ?? 0;
        final currentAssessment2 = currentData['Assessment2'] ?? 0;
        final currentAssessment3 = currentData['Assessment3'] ?? 0;

        final game2 = currentData['game2'] ?? 0;
        final game3 = currentData['game3'] ?? 0;

        // Update the document with Assessment1 and leave Assessment2 and Assessment3 unchanged
        transaction.update(docRef, {
          'Assessment1': currentAssessment1,
          'Assessment2': currentAssessment2,
          'Assessment3': currentAssessment3,
          'game1': _correctAnswersCount,
          'game2': game2,
          'game3': game3,
        });
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _images.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identify Image'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/PMSbackground.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_currentQuestionIndex < _images.length)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Leval ${_currentQuestionIndex + 1}',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      elevation: 4.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: Image.network(
                                _images[_currentQuestionIndex]['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ...List.generate(
                              _images[_currentQuestionIndex]['options'].length,
                              (optionIndex) {
                                String option = _images[_currentQuestionIndex]
                                    ['options'][optionIndex];
                                String correctOption =
                                    _images[_currentQuestionIndex]
                                        ['correctOption'];
                                bool isCorrect = option == correctOption;
                                return ElevatedButton(
                                  onPressed: () {
                                    _submitAnswer(
                                        optionIndex, correctOption, context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: _selectedOptions[
                                                    _currentQuestionIndex] !=
                                                null &&
                                            optionIndex ==
                                                _selectedOptions[
                                                    _currentQuestionIndex]
                                        ? (isCorrect
                                            ? MaterialStateProperty.all(
                                                Colors.green)
                                            : MaterialStateProperty.all(
                                                Colors.red))
                                        : null,
                                  ),
                                  child: Text(option),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      child: Text('Next'),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
              Text(
                'Score: $_correctAnswersCount',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
