import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Marks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Report')
            .where('name', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot marks = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    marks.data() as Map<String, dynamic>;
                String name =
                    data['name'] ?? 'Unknown'; // Handle null name field
                int assessment1 = data['Assessment1'] ?? 0;
                int assessment2 = data['Assessment2'] ?? 0;
                int assessment3 = data['Assessment3'] ?? 0;
                int game1 = data['game1'] ?? 0;
                int game2 = data['game2'] ?? 0;
                int game3 = data['game3'] ?? 0;
                int totalValue = assessment1 +
                    assessment2 +
                    assessment3 +
                    game1 +
                    game2 +
                    game3;
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text('Assessment1: $assessment1'),
                        Text('Assessment2: $assessment2'),
                        Text('Assessment3: $assessment3'),
                        Text('game1: $game1'),
                        Text('game2: $game2'),
                        Text('game3: $game3'),
                        SizedBox(height: 8.0),
                        Text(
                          'Total: $totalValue',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
