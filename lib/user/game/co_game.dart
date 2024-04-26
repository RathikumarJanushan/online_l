import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoGane extends StatefulWidget {
  @override
  _CoGaneState createState() => _CoGaneState();
}

class _CoGaneState extends State<CoGane> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  TextEditingController _answerController = TextEditingController();
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('game2').get();
    setState(() {
      _questions = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _answerController
            .clear(); // Clear the answer field for the next question
      }
    });
  }

  void _checkAnswer(String answer) async {
    if (answer == _questions[_currentQuestionIndex]['correctOption']) {
      setState(() {
        _score += 5; // Increment the score if the answer is correct
      }); // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Perform the Firestore transaction
      await _updateAssessmentMarks(userId, _score);

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

  Future<void> _updateAssessmentMarks(String userId, int _score) async {
    // Get the Firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Get the document reference
    final docRef = _firestore.collection('Report').doc(userId);

    // Start a Firestore transaction
    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(docRef);

      if (!doc.exists) {
        // If the document doesn't exist, create it with Assessment1 only
        transaction.set(docRef, {'game2': _score});
      } else {
        // If the document exists, update Assessment1 only
        final currentData = doc.data()!;
        final currentAssessment1 = currentData['Assessment1'] ?? 0;
        final currentAssessment2 = currentData['Assessment2'] ?? 0;
        final currentAssessment3 = currentData['Assessment3'] ?? 0;

        final game2 = currentData['game1'] ?? 0;
        final game3 = currentData['game3'] ?? 0;

        // Update the document with Assessment1 and leave Assessment2 and Assessment3 unchanged
        transaction.update(docRef, {
          'Assessment1': currentAssessment1,
          'Assessment2': currentAssessment2,
          'Assessment3': currentAssessment3,
          'game2': _score,
          'game1': game2,
          'game3': game3,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoGane'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_currentQuestionIndex < _questions.length)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question: ${_questions[_currentQuestionIndex]['question']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                              _questions[_currentQuestionIndex]['imageUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: _answerController,
                            decoration: InputDecoration(
                              labelText: 'Your Answer',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer(_answerController.text);
                    },
                    child: Text('Submit Answer'),
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
              'Score: $_score',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
