import 'package:flutter/material.dart';

const kActiveColour = Color(0xFF1D1E33);
const kInactiveColour = Color(0xFF111328);
const kBottomContainerHeight = 80.0;
const kBottomContainerColor = Color(0xFFEB1555);
const kStdIconColor = Color(0xFF8D8E98);

const maxHeight = 220;
const minHeight = 100;

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
const kTitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 35.0,
);

const kResultTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFF24D876),
);

const kBmiTextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);
const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
