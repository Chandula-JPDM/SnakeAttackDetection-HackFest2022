import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snake_detection_mobile_app/screens/camera_load_screen.dart';
import 'package:http/http.dart' as http;




class ImageUploadScreen extends StatefulWidget {
  String? image;
  ImageUploadScreen({required this.image});
  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  
  void image_uploader(String image_path) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://snakead-api.herokuapp.com/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', image_path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
          height: 200,
          width: 300,
          child: Image.file(File(widget.image!), height: 200, width: 300,),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => CameraScreen())));
        },
        child: Container(
          child: Center(
              child: Text(
            'Back',
            style: TextStyle(color: Colors.white),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.orange,
          ),
          height: 40,
          width: 150,
        ),
      ),SizedBox(width: 10,), 
             GestureDetector(
        onTap: () async {
          print('uploading image..');
          print(widget.image);
          image_uploader(widget.image!);
          
        },
        child: Container(
          child: Center(
              child: Text(
            'Upload Image',
            style: TextStyle(color: Colors.white),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.teal,
          ),
          height: 40,
          width: 150,
        ),
      )
          ],
        )
      ]),
    );
  }
}
