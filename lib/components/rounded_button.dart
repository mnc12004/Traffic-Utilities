import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.color, @required this.onPressed, this.title});

  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Material(
        elevation: 10.0,
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        borderOnForeground: true,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 150.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
