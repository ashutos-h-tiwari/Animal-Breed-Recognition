import 'package:flutter/material.dart';
import 'dart:async';
 // Import your login page here
import 'package:sih/Front-End/Login-Signup/Login.dart';

import '../image_picker/imgPick.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();

    // Navigate to Login after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PickImagePage()),
        // MaterialPageRoute(builder: (context) => LoginPage()),

      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Your app logo or icon here with animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.shade300,
                ),
                child: Icon(
                  Icons.pets,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Animal Breed Recognizer',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Powered by AI & Flutter',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple.shade100,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
