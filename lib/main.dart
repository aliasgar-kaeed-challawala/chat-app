import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_flutter/screens/welcome_screen.dart';
import 'package:chat_app_flutter/screens/login_screen.dart';
import 'package:chat_app_flutter/screens/registration_screen.dart';
import 'package:chat_app_flutter/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   primaryColor: Color(0xff003049),
      //   textTheme: TextTheme(
      //     bodyText2: TextStyle(color: Colors.white),
      //   ),
      // ),

      initialRoute: WelcomeScreen.id,
      routes: {

        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        ChatScreen.id : (context) => ChatScreen(),
      },
    );
  }
}
