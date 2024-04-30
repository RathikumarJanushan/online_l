import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuestionScreen3 extends StatefulWidget {
  @override
  _AddQuestionScreen3State createState() => _AddQuestionScreen3State();
}

class _AddQuestionScreen3State extends State<AddQuestionScreen3> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  final TextEditingController _correctOptionController =
      TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitQuestion() async {
    String question = _questionController.text.trim();
    String option1 = _option1Controller.text.trim();
    String option2 = _option2Controller.text.trim();
    String option3 = _option3Controller.text.trim();
    String option4 = _option4Controller.text.trim();
    String correctOption = _correctOptionController.text.trim();

    try {
      await _firestore.collection('questions3').add({
        'question': question,
        'options': [option1, option2, option3, option4],
        'correctOption': correctOption,
      });
      print('Question submitted successfully');
      // Clear text fields after submission
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      _correctOptionController.clear();
    } catch (e) {
      print('Error submitting question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/PMSbackground.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  controller: _option1Controller,
                  decoration: InputDecoration(labelText: 'Option 1'),
                ),
                TextField(
                  controller: _option2Controller,
                  decoration: InputDecoration(labelText: 'Option 2'),
                ),
                TextField(
                  controller: _option3Controller,
                  decoration: InputDecoration(labelText: 'Option 3'),
                ),
                TextField(
                  controller: _option4Controller,
                  decoration: InputDecoration(labelText: 'Option 4'),
                ),
                TextField(
                  controller: _correctOptionController,
                  decoration: InputDecoration(labelText: 'Correct Option'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitQuestion,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
