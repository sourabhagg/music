import 'package:music/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:music/widgets/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme:MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      title: 'Myapp',
      home: HomeScreen(),
    );
  }
}