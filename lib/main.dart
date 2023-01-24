import 'package:chat_genie/Model/firebase_helper.dart';
import 'package:chat_genie/Model/user_model.dart';
import 'package:chat_genie/Views/Onboarding/login_page.dart';
import 'package:chat_genie/Views/Screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);
  if(currentUser != null) {
    // Logged In
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
    if(thisUserModel != null) {
      runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else {
      runApp(MyApp());
    }
  }
  else {
    // Not logged in
    runApp(MyApp());
  }
}

// Not Logged IN
 class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: LoginPage(firebaseUser: null, userModel: null),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
      debugShowCheckedModeBanner: false,
    );
  }
}
