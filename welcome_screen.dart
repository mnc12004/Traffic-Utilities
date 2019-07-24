import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trafficutilities/components/rounded_button.dart';
import 'package:trafficutilities/screens/login_screen.dart';
import 'package:trafficutilities/screens/register_screen.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
  
    super.initState();

    getCurrentUser();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Utilities'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: [
                    'Traffic Utilities',
                    'Information,',
                    'when you need it...',
                    'where you want it...'
                  ],
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: () {
                //Go to login screen.
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blue,
              title: 'Register',
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegisterScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
