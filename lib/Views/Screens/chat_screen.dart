import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundImage: CachedNetworkImageProvider(
                  """
https://images.unsplash.com/photo-1494790108377-be9c29b29330?
ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"""),
              radius: 20,
            ),
            SizedBox(width: 05,),
            Text('Michael❤❤'),
          ],
        ),
        actions: [
          Icon(Icons.video_call, size: 30, color: Colors.white),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.call, size: 25, color: Colors.white),
          SizedBox(
            width: 16,
          ),
          Icon(Icons.more_vert_rounded, size: 25, color: Colors.white),
        ],
        automaticallyImplyLeading: true,titleSpacing: 2.0,
      ),
    );
  }
}
