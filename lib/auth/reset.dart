import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                resetPassword(email); // Call resetPassword function
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      print("Password reset email sent to $email");
    } catch (error) {
      // Handle password reset errors
      print("Password reset failed: $error");
    }
  }
}
