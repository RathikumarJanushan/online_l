import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:online_learning/admin/add_video.dart';

import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/signup_screen.dart';
import 'package:online_learning/admin/adminhome_screen.dart';
import 'package:online_learning/user/game/game.dart';
import 'package:online_learning/user/video.dart';
import 'package:online_learning/user/home_screen.dart';
import 'package:online_learning/user/learning_material.dart';
import 'package:online_learning/widgets/button.dart';
import 'package:online_learning/widgets/textfield.dart';
import 'package:online_learning/auth/reset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/PMSbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Spacer(),
              const Text("Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
              const SizedBox(height: 50),
              CustomTextField(
                hint: "Enter Email",
                label: "Email",
                controller: _email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: "Enter Password",
                label: "Password",
                isPassword: true,
                controller: _password,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                  );
                },
                child: Text(
                  "Forgotten Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: "Login",
                onPressed: _login,
                textColor: Colors.white, // Text color
                buttonColor: Color.fromARGB(255, 11, 126, 164), // Button color
              ),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child:
                      const Text("Signup", style: TextStyle(color: Colors.red)),
                )
              ]),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LearningMaterialPage()),
      );

  goToAdminHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  AdminhomeomeScreen()),
      );

  _login() async {
    print("Attempting login with email: ${_email.text}");

    if (_password.text.isEmpty) {
      _showErrorDialog("Password field cannot be empty.");
      return;
    }

    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In: ${user.uid}");

      // Check if the user's email is admin@gmail.com
      if (_email.text == "admin@gmail.com") {
        print("Admin logged in");
        // Navigate to the admin home screen
        goToAdminHome(context);
      } else {
        print("Regular user logged in");
        // Navigate to the regular home screen
        goToHome(context);
      }
    } else {
      print("Login failed");
      _showErrorDialog("Incorrect email or password. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
