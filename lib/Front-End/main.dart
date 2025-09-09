import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class MyApp extends StatefulWidget {
  // ... as before
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _uploadStatus;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _selectedImage = image;
        _uploadStatus = null;
      });
    } catch (e) {
      setState(() {
        _uploadStatus = 'Image pick error: $e';
      });
    }
  }

  Future<void> uploadImageToBackend(XFile imageFile) async {
    try {
      var dio = Dio();
      String filename = imageFile.path.split('/').last;
      var formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path, filename: filename),
      });
      Response response = await dio.post(
        "https://your-backend-api-url.com/upload", // Use your real endpoint
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      setState(() {
        _uploadStatus = "Upload successful: ${response.statusCode}";
      });
    } catch (e) {
      setState(() {
        _uploadStatus = "Upload failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... rest of the UI
      body: Center(
        child: Column(
          children: [
            _selectedImage != null
                ? Image.file(File(_selectedImage!.path), height: 200)
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedImage != null
                  ? () => uploadImageToBackend(_selectedImage!)
                  : null,
              child: Text('Send Image to Backend'),
            ),
            if (_uploadStatus != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(_uploadStatus!, style: TextStyle(color: Colors.green)),
              ),
          ],
        ),
      ),
    );
  }
}
