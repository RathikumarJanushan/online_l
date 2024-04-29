import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class assessmentScreen3 extends StatefulWidget {
  @override
  _assessmentScreen3State createState() => _assessmentScreen3State();
}

class _assessmentScreen3State extends State<assessmentScreen3> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _questions = [];
  int _correctAnswersCount = 0;
  late List<int?> _selectedOptions;

  _assessmentScreen3State() {
    _selectedOptions = [];
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('questions3').get();
    setState(() {
      _questions = querySnapshot.docs.map((doc) => doc.data()).toList();
      _selectedOptions = List.generate(_questions.length, (_) => null);
    });
  }

  void _submitAnswer(int questionIndex, int optionIndex, String correctOption,
      BuildContext context) async {
    if (_selectedOptions[questionIndex] != null) {
      return; // Answer already selected
    }

    int assessmentMarks =
        0; // Initialize assessmentMarks outside the conditional statement

    setState(() {
      _selectedOptions[questionIndex] = optionIndex;
    });

    if (optionIndex ==
        _questions[questionIndex]['options'].indexOf(correctOption)) {
      setState(() {
        _correctAnswersCount++;
      });
      // Show correct feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show incorrect feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    assessmentMarks = _correctAnswersCount +=
        1; // Calculate assessmentMarks based on correct answers count

    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Perform the Firestore transaction
    await _updateAssessmentMarks(userId, assessmentMarks);
  }

  Future<void> _updateAssessmentMarks(
      String userId, int assessmentMarks) async {
    // Get the Firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Get the document reference
    final docRef = _firestore.collection('Report').doc(userId);

    // Start a Firestore transaction
    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(docRef);

      if (!doc.exists) {
        // If the document doesn't exist, create it with Assessment1 only
        transaction.set(docRef, {'Assessment3': assessmentMarks});
      } else {
        // If the document exists, update Assessment1 only
        final currentData = doc.data()!;
        final currentAssessment2 = currentData['Assessment2'] ?? 0;
        final currentAssessment3 = currentData['Assessment1'] ?? 0;
        final game1 = currentData['game1'] ?? 0;
        final game2 = currentData['game2'] ?? 0;
        final game3 = currentData['game3'] ?? 0;

        // Update the document with Assessment1 and leave Assessment2 and Assessment3 unchanged
        transaction.update(docRef, {
          'Assessment3': assessmentMarks,
          'Assessment2': currentAssessment2,
          'Assessment1': currentAssessment3,
          'game1': game1,
          'game2': game2,
          'game3': game3,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('assessment 3'),
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
              Text(
                'Questions',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, questionIndex) {
                    Map<String, dynamic> question = _questions[questionIndex];
                    List<dynamic> options = question['options'];
                    String correctOption = question['correctOption'];
                    return Card(
                      elevation: 4.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              question['question'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ...List.generate(
                              options.length,
                              (optionIndex) {
                                String option = options[optionIndex];
                                bool isCorrect = option == correctOption;
                                return ElevatedButton(
                                  onPressed: () {
                                    _submitAnswer(questionIndex, optionIndex,
                                        correctOption, context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: _selectedOptions[
                                                    questionIndex] !=
                                                null &&
                                            optionIndex ==
                                                _selectedOptions[questionIndex]
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
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Correct Answers: $_correctAnswersCount',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
