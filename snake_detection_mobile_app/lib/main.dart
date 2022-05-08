import 'package:flutter/material.dart';
import 'package:snake_detection_mobile_app/screens/camera_load_screen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CameraScreen());
  }
}
