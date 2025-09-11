import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImagePage extends StatefulWidget {
  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? backendResponse;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        backendResponse = null;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image first')));
      return;
    }

    setState(() {
      isLoading = true;
      backendResponse = null;
    });

    // Simulate backend call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
      backendResponse = '✅ Image uploaded successfully!\n🐾 Recognized Breed: Golden Retriever';
    });
  }

  Widget _buildGradientButton(String text, VoidCallback? onPressed, {bool isLoading = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
          )
              : Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Breed Recognizer'),
        centerTitle: true,
        elevation: 8,
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.deepPurpleAccent,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
                Icons.more_vert,

            ),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'contribution') {
                // Handle "Find Out Contribution" click
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Contribution'),
                    content: Text('Thanks for your interest! This app was built by Ashutosh Tiwari. Contributions are welcome!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      )
                    ],
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'contribution',
                  child: Text('Find Out Contribution'),
                ),
              ];
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _imageFile != null
                  ? Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.deepPurple.shade100, blurRadius: 15, offset: Offset(0, 8))],
                ),
                child: Image.file(
                  _imageFile!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.shade50,
                  boxShadow: [BoxShadow(color: Colors.deepPurple.shade100, blurRadius: 15, offset: Offset(0, 8))],
                ),
                child: Icon(Icons.image_outlined, size: 110, color: Colors.deepPurple.shade300),
              ),
            ),
            SizedBox(height: 40),
            _buildGradientButton('Pick Image from Gallery', isLoading ? null : _pickImage),
            SizedBox(height: 24),
            _buildGradientButton('Send to Backend', isLoading ? null : _uploadImage, isLoading: isLoading),
            SizedBox(height: 36),
            if (backendResponse != null)
              Container(
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.deepPurple.shade200),
                  boxShadow: [BoxShadow(color: Colors.deepPurple.shade100, blurRadius: 12, offset: Offset(0, 6))],
                ),
                child: Text(
                  backendResponse!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
