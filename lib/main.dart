import 'package:chat_genie/Views/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,

    );
  }
}

