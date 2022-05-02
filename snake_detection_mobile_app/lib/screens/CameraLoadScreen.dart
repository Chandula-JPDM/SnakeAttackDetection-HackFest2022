import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snake_detection_mobile_app/screens/image_upload_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  File? _flutterImage;
  Future imgFromCamera() async {
    try {
      var status = await Permission.camera.status;
      print("camera permission status: $status");
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      // print("DEBUG >> image path: " + image.path);
      setState(() {
        _flutterImage = imageTemporary;
      });
      // context.read<ImageData>().image = imageTemporary;
      // print(imageTemporary);
      return imageTemporary;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          
          child: GestureDetector(
        onTap: () async {
          print('button click..');
          File? imageName = await imgFromCamera();
          print(imageName);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ImageUploadScreen(image: imageName))));
        },
        child: Container(
          child: Center(
              child: Text(
            'Go to Camera',
            style: TextStyle(color: Colors.white),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.orange
  
          ),
          height: 120,
          width: 120,
        ),
      )),
    );
  }
}
