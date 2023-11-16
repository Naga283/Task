import 'package:flutter/material.dart';

class AppStyles {
  final boxShadow = [
    BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 4.0, // soften the shadow
      spreadRadius: 2.0, //extend the shadow
      offset: Offset(
        0.0, // Move to right 5  horizontally
        0.0, // Move to bottom 5 Vertically
      ),
    )
  ];
}

final appStyles = AppStyles();
