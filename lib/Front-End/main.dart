import 'package:flutter/material.dart';

import 'Login-Signup/Login.dart';
import 'splash-Screen/splashscr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      home: SplashScreen(),
    );
  }
}

