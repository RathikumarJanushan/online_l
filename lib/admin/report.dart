import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Report').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot marks = snapshot.data!.docs[index];
                String name = marks.id; // Name of the assessment or game
                int marksValue = marks['marks']; // Marks obtained
                return ListTile(
                  title: Text(name),
                  subtitle: Text('Marks: $marksValue'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MarksList(),
  ));
}
