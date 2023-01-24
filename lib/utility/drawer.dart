// import 'package:chat_genie/Model/user_model.dart';
// import 'package:chat_genie/Views/Onboarding/login_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyDrawer extends StatefulWidget {
//   const MyDrawer({Key? key}) : super(key: key);
//
//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }
//
// class _MyDrawerState extends State<MyDrawer> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//       setState(() {});
//     });
//   }
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: const Color(0xfffeefe2),
//         child: ListView(
//           children: [
//               DrawerHeader(
//                   padding: EdgeInsets.zero,
//                   child: UserAccountsDrawerHeader(
//                     decoration: const BoxDecoration(
//                       color: Color(0xfffeefe2),
//                     ),
//                     margin: EdgeInsets.zero,
//                     accountName: Text(
//                       "${loggedInUser.firstName} ${loggedInUser.secondName}",
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     accountEmail: Text(
//                       "${loggedInUser.email}",
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     currentAccountPicture: const CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/logo.png"),
//                     ),
//                   ),
//         ),
//
//             const ListTile(
//               leading: Icon(
//                 Icons.language_sharp,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 "Visit Website",
//                 textScaleFactor: 1.5,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.construction),
//               title: const Text(
//                 "Flipkart Store",
//                 textScaleFactor: 1.5,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const ListTile(
//               leading: Icon(
//                 Icons.support_agent_sharp,
//                 color: Colors.black, //Color of Icon
//               ),
//               title: Text(
//                 "Support",
//                 textScaleFactor: 1.5,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             ListTile(
//               onTap: (){
//                 logout(context);
//               },
//               leading: const Icon(
//                 Icons.logout,
//                 color: Colors.black,
//               ),
//               title: const Text(
//                 "Logout",
//                 textScaleFactor: 1.5,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // the logout function
// Future<void> logout(BuildContext context) async {
//   await FirebaseAuth.instance.signOut();
//   Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => const LoginPage()));
// }
//
//
