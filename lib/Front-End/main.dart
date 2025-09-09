import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Login-Signup/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      home: LoginPage(),
    );
  }
}

