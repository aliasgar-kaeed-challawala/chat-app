import 'package:flutter/material.dart';
import 'package:chat_app_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
User loggedInUser;
String message;

@override
  void initState() {
   
    super.initState();
    getCurrentUser();
  }


void getCurrentUser(){

  try{
    final user =  _auth.currentUser;
    if(user!=null){
      loggedInUser = user;
      // print(loggedInUser.email);
    }

  }
  catch(e){
      print(e);
  }
}
void messagesStream() async{
  await for(var snapshot in _firestore.collection('Messages').snapshots()){
    for(var message in snapshot.docs){
      print(message.data());
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
//                _auth.signOut();
//                Navigator.pop(context);
//              getMessage();
              messagesStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color(0xffd62828),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestore.collection('Messages').add({

                        'Text':message,
                        'Sender':loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
