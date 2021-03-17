import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('movies',
              style: TextStyle( fontSize: 30)),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}