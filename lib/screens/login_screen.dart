// import 'dart:html';

import 'package:chat_app_flutter/components/RoundedButton.dart';
import 'package:chat_app_flutter/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_flutter/constants.dart';

class LoginScreen extends StatefulWidget {  
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final _auth = FirebaseAuth.instance;
String email;
String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003049),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'flash_img',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
               email = value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Color(0xfffcbf49),
              text: 'Log In',
              onPressed: () async{
                try{
                final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                if(user!=null){
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                }
                catch(e){
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
