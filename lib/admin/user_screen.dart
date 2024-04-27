import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  Future<void> _deleteUser(String userId, String email) async {
    try {
      // Delete the user document from the Firestore collection
      await FirebaseFirestore.instance.collection('usersdetails').doc(userId).delete();

    //       final userToDelete = await FirebaseAuth.instance.getUserByEmail(email);
    // if (userToDelete != null) {
    //   await userToDelete.delete();
    // }

    } catch (e) {
      // Handle any errors that occur during deletion
      print('Error deleting user: $e');
      // You can display an error message to the user if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usersdetails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final users = snapshot.data?.docs ?? [];

          if (users.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          return DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Action')), // New column for delete button
            ],
            rows: users.map((DocumentSnapshot document) {
              final userData = document.data() as Map<String, dynamic>;
              final userId = document.id;
              final name = userData['name'] ?? 'N/A';
              final email = userData['email'] ?? 'N/A';

              return DataRow(
                cells: [
                  DataCell(Text(name)),
                  DataCell(Text(email)),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Show a confirmation dialog before deleting the user
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Deletion'),
                              content: Text('Are you sure you want to delete this user?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteUser(userId, email); // Call the delete function
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
