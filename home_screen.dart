import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficutilities/components/custom_widgets.dart';
import 'package:trafficutilities/screens/chat_screen.dart';
import 'package:trafficutilities/screens/rego_check_screen.dart';
import 'package:trafficutilities/screens/welcome_screen.dart';

import 'breath_calc_screen.dart';
import 'lams_screen.dart';
import 'my_links_screen.dart';
import 'profile_screen.dart';
import 'web_rego_check.dart';
import 'where_am_i_screen.dart';

const String APP_TITLE = 'Traffic Utilities';
const String APP_VERSION = '1.0.5';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  String fullName = 'User';
  String emailAddress = 'Email';
  String
      profileImage; // = 'https://firebasestorage.googleapis.com/v0/b/offencesearchsystem.appspot.com/o/assets%2Fanon.png?alt=media&token=bf11e3c7-be65-4645-95a1-64640dac028d';

//  final _kBottomNavBarItems = <BottomNavigationBarItem>[
//    BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Profile')),
//    BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Where Am I`')),
//  ];

  static final FirebaseDatabase database = FirebaseDatabase();
  DatabaseReference reference = database.reference().child('users');

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
            var profileImage = user.photoUrl;

            fullName = name;
            emailAddress = email;
            profileImage = profileImage;
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    getCurrentUser();
    // Nav Drawer
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/blurredpolice.jpeg'),
        ),
      ),
      accountName: Text(fullName),
      accountEmail: Text(emailAddress),
      currentAccountPicture: CircleAvatar(
        child: Image(
          image: profileImage != null
              ? NetworkImage(profileImage)
              : NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/offencesearchsystem.appspot.com/o/assets%2Fanon.png?alt=media&token=bf11e3c7-be65-4645-95a1-64640dac028d'),
        ),
        backgroundColor: Colors.lightBlue[50],
        radius: 40.0,
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Offence Search System'),
          leading: Icon(FontAwesomeIcons.binoculars),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            var title = 'WA Traffic Offences';
            var url = 'https://infsearch.azurewebsites.net/htmlclient';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebRegoCheck(url: url, title: title),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Breath Test Calculator'),
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(FontAwesomeIcons.calculator),
          onTap: () {
            Navigator.pushNamed(context, BreathCalcScreen.id);
          },
        ),
        ListTile(
          title: Text('Vehicle Rego Checks'),
          leading: Icon(FontAwesomeIcons.car),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, RegoCheckScreen.id);
          },
        ),
        ListTile(
          title: Text('Temp Movement Permit Search'),
          leading: Icon(FontAwesomeIcons.search),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            var title = 'WA Temporary Movement Search';
            var url = 'https://www.transport.wa.gov.au/LandingPage.asp?permit';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebRegoCheck(url: url, title: title),
              ),
            );
          },
        ),
        ListTile(
          title: Text('L.A.M.S. Info'),
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(FontAwesomeIcons.motorcycle),
          onTap: () {
            Navigator.pushNamed(context, LAMSScreen.id);
          },
        ),
        Divider(),
        ListTile(
          title: Text('Where Am I?'),
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(FontAwesomeIcons.map),
          onTap: () {
            Navigator.pushNamed(context, WhereAmIScreen.id);
          },
        ),
        Divider(),
        ListTile(
          title: Text('My Profile'),
          leading: Icon(FontAwesomeIcons.user),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.id);
          },
        ),
        ListTile(
          title: Text('My Links'),
          leading: Icon(FontAwesomeIcons.link),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, MyLinksScreen.id);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(FontAwesomeIcons.info),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('About'),
          onTap: () {
            showAboutDialog(
                context: context,
                applicationName: APP_TITLE,
                applicationVersion: APP_VERSION,
                applicationIcon: FlutterLogo(size: 30),
                children: <Widget>[Text('The New Traffic Utilities')]);
          },
        ),
      ],
    );
//     End Nav Drawer
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Utilities'),
        centerTitle: true,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.lightBlue[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, BreathCalcScreen.id);
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.calculator,
                            iconColor: Colors.white,
                            tileText: 'BREATH CALCULATOR',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ChatScreen.id);
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.commentDots,
                            iconColor: Colors.white,
                            tileText: 'TRAFFIC CHAT',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var title = 'WA Traffic Offences';
                          var url =
                              'https://infsearch.azurewebsites.net/htmlclient';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebRegoCheck(url: url, title: title),
                            ),
                          );
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.fileInvoice,
                            iconColor: Colors.white,
                            tileText: 'OFFENCE\nSEARCH',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegoCheckScreen.id);
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.clipboardCheck,
                            iconColor: Colors.white,
                            tileText: 'REGISTRATION CHECKS',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, WhereAmIScreen.id);
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.map,
                            iconColor: Colors.white,
                            tileText: 'WHERE AM I?',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MyLinksScreen.id);
                        },
                        child: ReusableCard(
                          colour: Color(0xFF1565C0),
                          cardChild: CustomIconContent(
                            tileIcon: FontAwesomeIcons.link,
                            iconColor: Colors.white,
                            tileText: 'MY LINKS',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
