import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app_flutter/components/RoundedButton.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_flutter/screens/login_screen.dart';
import 'package:chat_app_flutter/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    // animation = ColorTween(begin: Color(0xffd62828), end: Color(0xffeae2b7)).animate(controller);
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 60.0,
    );

    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

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
            Row(
              children: <Widget>[
                Hero(
                  tag: 'flash_img',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                    color: Color(0xfffcbf49),
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Flash Chat'),
                      
                    ],
                    isRepeatingAnimation: true,
                    
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            //Color(0xfffcbf49)
            RoundedButton(text: 'Log In',color: Color(0xfffcbf49), onPressed:(){Navigator.pushNamed(context, LoginScreen.id);}),
            RoundedButton(text: 'Register',color: Color(0xfff77f00), onPressed:(){Navigator.pushNamed(context, RegistrationScreen.id);}),
          ],
        ),
      ),
    );
  }
}

