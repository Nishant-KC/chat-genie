import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_genie/Model/user_model.dart';
import 'package:chat_genie/Views/Screens/chat_screen.dart';
import 'package:chat_genie/utility/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'ChatApp',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            elevation: 0.0,
            actions: [
              Icon(Icons.photo_camera_outlined, size: 30, color: Colors.white),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.search_sharp, size: 30, color: Colors.white),
              SizedBox(
                width: 16,
              ),
              Icon(Icons.more_vert_rounded, size: 30, color: Colors.white),
            ],
            bottom:
                TabBar(automaticIndicatorColorAdjustment: true, tabs: const [
              Tab(
                child: Text('Chats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
              Tab(
                child: Text('Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
              Tab(
                child: Text('Calls',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
            ]),
          ),
          // drawer: MyDrawer(),
          body: Stack(children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: LayoutBuilder(builder: (BuildContext, constraints) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Michael ',
                                      style: TextStyle(fontSize: 18)),
                                  Text("Hey I'm using Chat APP",
                                      style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  })),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  //FloatingActionButton
                  onPressed: () {
                    print('ADD');
                  },
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
