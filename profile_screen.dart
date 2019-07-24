import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficutilities/components/rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  String fullName = 'User';
  String emailAddress = 'Email';
  String workLocation = 'Forms of Government.';
  String regimental = 'PD12345';
  String imageURL =
      'https://firebasestorage.googleapis.com/v0/b/offencesearchsystem.appspot.com/o/assets%2Fanon.png?alt=media&token=bf11e3c7-be65-4645-95a1-64640dac028d';

  @override
  void initState() {
    super.initState();
// Biggest issue with this file is that getCurrentUser() doesn't get called for some reason.
// It only gets called when the edit profile button is pressed????
    getCurrentUser();
  }

  static final FirebaseDatabase database = FirebaseDatabase();
  DatabaseReference reference = database.reference().child('users');

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile of, $fullName'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    radius: 90.0,
                    backgroundColor: Colors.white,
                    child: FadeInImage(
                      placeholder: NetworkImage(
                          'https://trafficutilities.com.au/images/logo.png'),
                      image: NetworkImage(imageURL),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 10.0,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          isThreeLine: true,
                          leading: Icon(FontAwesomeIcons.userShield),
                          title: Text(
                            fullName,
                          ),
                          subtitle: Text(emailAddress),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 10.0,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.medal),
                      title: Text('Regimental Number'),
                      subtitle: Text(regimental),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 10.0,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.warehouse),
                      title: Text('Work Location'),
                      subtitle: Text(workLocation),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      RoundedButton(
                        color: Colors.green,
                        title: 'Change your Password',
                        onPressed: () {
                          final emailAddress = firebaseUser.email;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text(
                                'Change Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                              content: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                          'Changing your password? Enter $emailAddress in the field below.'),
                                      TextField(),
                                      RoundedButton(
                                          title: 'Send Password reset Email',
                                          color: Colors.green,
                                          onPressed: () {
                                            resetPassword(emailAddress);

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
                      RoundedButton(
                          color: Colors.blue,
                          title: 'Edit your profile',
                          onPressed: () {
                            final _name = TextEditingController();
                            final _location = TextEditingController();
                            final _rego = TextEditingController();
                            var fn;
                            var loc;
                            var rego;

                            setState(() {
                              _name.text = fullName;
                              _location.text = workLocation;
                              _rego.text = regimental;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text('Edit Profile'),
                                content: SingleChildScrollView(
                                  child: Container(
                                    height: 310.0,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          TextField(
                                            controller: _name,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  'Full Name (or Nick Name)',
                                            ),
                                            onChanged: (value) {
                                              fn = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          TextField(
                                            controller: _location,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Work Location',
                                            ),
                                            onChanged: (value) {
                                              loc = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          TextField(
                                            controller: _rego,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Regimental',
                                            ),
                                            onChanged: (value) {
                                              rego = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Center(
                                            child: ButtonBar(
                                              children: <Widget>[
                                                RoundedButton(
                                                  color: Colors.orange,
                                                  title: 'Commit Changes',
                                                  onPressed: () {
                                                    if (fn == null) {
                                                      fn = _name.text;
                                                    }
                                                    if (loc == null) {
                                                      loc = _location.text;
                                                    }
                                                    if (rego == null) {
                                                      rego = _rego.text;
                                                    }
                                                    setState(() {
                                                      final uid =
                                                          firebaseUser.uid;
                                                      reference
                                                          .child(uid)
                                                          .update({
                                                        'full_name': fn,
                                                        'location': loc,
                                                        'regimental': rego,
                                                      });
                                                      getCurrentUser();
                                                      //print(
                                                      //   'Got Data:\nUserId; $uid\nLocation: $loc\nFull Name: $fn\nRegimental: $rego');
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser();

    try {
      if (user != null) {
        firebaseUser = user;
        String uid = firebaseUser.uid;
        setState(() {
          reference.child(uid).once().then((DataSnapshot snap) {
            var name = snap.value['full_name'];
            var email = snap.value['email'];
            var workLoc = snap.value['location'];
            var rego = snap.value['regimental'];
            var profileImage = user.photoUrl;

            if (profileImage == null) {
              profileImage = 'https://trafficutilities.com.au/images/logo.png';
            }

            fullName = name;
            emailAddress = email;
            workLocation = workLoc;
            regimental = rego;
            imageURL = profileImage;
            print('Photo Url: $imageURL');
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
