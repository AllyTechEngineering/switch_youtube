import 'package:flutter/material.dart';
import 'package:switch_youtube/screens/switch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Embedded Switch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwitchScreen(),
    );
  }
}
