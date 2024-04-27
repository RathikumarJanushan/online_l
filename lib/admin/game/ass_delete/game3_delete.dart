import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class game3_delete extends StatelessWidget {
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
            body: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('ToFGame').snapshots(),
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
                    return ListTile(
                      title: Text(questionData['question']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (questionData['selection'] is List)
                            ...List.generate(
                              (questionData['selection'] as List).length,
                              (optionIndex) => Text(
                                (questionData['selection'] as List)[optionIndex],
                              ),
                            ),
                          if (questionData['selection'] is bool)
                            Text(questionData['selection'].toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _firestore
                              .collection('ToFGame')
                              .doc(questions[index].id)
                              .delete();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}