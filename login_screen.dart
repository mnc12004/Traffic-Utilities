import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:trafficutilities/components/rounded_button.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  bool showSpinner = false;
  bool _obscureText = true;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: eController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  setState(() {
                    this.email = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: pController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                obscureText: _obscureText,
                enabled: eController.text.isEmpty ? false : true,
                onChanged: (value) {
                  setState(() {
                    this.password = value;
                  });
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.orange,
                title: 'Sign In...',
                onPressed: eController.text.isEmpty
                    ? null
                    : pController.text.isEmpty
                        ? null
                        : () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      )
                                    ],
                                    title: Text('An Error Occurred'),
                                    content: Text(
                                      e.message,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                );
                              });

                              print(e);
                            }
                          },
              ),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(
                child: Text(
                  'Forgot Your Password?',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        'Reset Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Lost your password?\nEnter the email address you registered with in the field below.',
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              RoundedButton(
                                  title: 'Send Password Reset Email',
                                  color: Colors.green,
                                  onPressed: () {
                                    resetPassword(email);

                                    Navigator.pop(context);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Text('or...',
                    style:
                        TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
              ),
              RoundedButton(
                onPressed: () {
                  _handleSignIn()
                      .then((FirebaseUser user) => print('Google User: $user'))
                      .catchError((e) => print(e));
                },
                title: 'Sign in with Google',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    if (user != null) {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }

    return user;
  }
}
