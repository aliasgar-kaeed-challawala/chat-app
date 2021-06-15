import 'package:flutter/material.dart';
import 'package:chat_app_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String message;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
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
                _auth.signOut();
                Navigator.pop(context);
                //  getMessage();
                // messagesStream();
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
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xff003049)))),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffd62828)),
                    ),
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('Messages').add({
                        'Text': message,
                        'Sender': loggedInUser.email,
                      });
                    },
                    child: Icon(
                      Icons.send,
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

class MessageStream extends StatelessWidget {
   
    

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xffd62828),
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MsgBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.get('Text');
          final messageSender = message.get('Sender');

          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}

          final messageBubble = MsgBubble(
            sender: messageSender,
            text: messageText,
            amI: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MsgBubble extends StatelessWidget {
  MsgBubble({this.text, this.sender, this.amI});

  final String sender;
  final String text;
  final bool amI;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            amI ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Material(
              elevation: 5.0,
              borderRadius: amI
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              color: amI ? Color(0xff003049) : Color(0xffd62828),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '$text',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
