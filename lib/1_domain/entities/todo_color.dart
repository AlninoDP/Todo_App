import 'package:flutter/material.dart';

class ToDoColor {
  final int colorIndex;

  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.blueGrey,
    Colors.yellow,
    Colors.purple,
    Colors.teal,
    Colors.orange
  ];

  Color get color => predefinedColors[colorIndex];

  ToDoColor({required this.colorIndex});
}
