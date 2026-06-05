import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TDMU Notes',
      themeMode: ThemeMode.system, // Theo cài đặt máy
      // main.dart
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily:
            'Times New Roman', // Hoặc 'Georgia', 'Times New Roman' tùy máy
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: HomeScreen(),
    );
  }
}
