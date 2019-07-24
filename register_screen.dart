import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:trafficutilities/components/rounded_button.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState({this.email, this.password});

  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();

  var email;
  var password;
  bool _pwdValid = false;

  bool _obscureText = true;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Traffic Utilties - Registration',
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                height: 15.0,
              ),
              TextField(
                controller: eController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: pController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  errorText: _pwdValid ? 'Password is required' : null,
                  enabled: eController.text.isEmpty ? false : true,
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.orange,
                title: 'Register...',
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
                                  await _auth.createUserWithEmailAndPassword(
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
              Center(
                child: Text('or...',
                    style:
                        TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
              ),
              RoundedButton(
                onPressed: () {
                  _handleSignIn()
                      .then((FirebaseUser user) => print('Google USer: $user'))
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

    //End Widget Build Context
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
