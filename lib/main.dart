import 'package:chat_genie/Views/Onboarding/login_page.dart';
import 'package:chat_genie/Views/Screens/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

