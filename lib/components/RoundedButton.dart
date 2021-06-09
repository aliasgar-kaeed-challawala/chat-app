import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  
  RoundedButton({this.text,this.color,@required this.onPressed});
  final Color color;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 45.0,
          child: Text(
            text,
            
          ),
        ),
      ),
    );
  }
}
