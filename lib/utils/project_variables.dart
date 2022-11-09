import 'package:flutter/material.dart';

//uygulama genelinde tasarım değişiklerini tek bir yerden ele almak için
//widgetlar içinde ProjectStyles.titleStyle gibi erişilebilir.
class ProjectStyles {
  static const TextStyle titleStyle = TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle navigationTextStyle = TextStyle(fontSize: 20);
  static const TextStyle resultTextStyle = TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle newsCardBottomDetails = TextStyle(fontSize: 15, color: Colors.black);
  static const TextStyle newsDetailsTitle = TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle newsDetailsDetail = TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400);
}

class ProjectColors {
  static const Color splashColor = Colors.blue;
  static Color cardBackgroundColor = const Color.fromARGB(255, 239, 237, 237);
}
