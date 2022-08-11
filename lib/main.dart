import 'package:flutter/material.dart';
import 'package:google_keep_clone/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.black.withOpacity(0.7),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColorLight: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
