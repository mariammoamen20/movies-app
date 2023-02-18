import 'package:flutter/material.dart';

class MoviesDetailsScreen extends StatelessWidget {
  String title;

  MoviesDetailsScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: const TextStyle(
          fontSize: 16.0,
        ),),
      ),
    );
  }
}
