import 'package:flutter/material.dart';
import 'package:trafficutilities/screens/breath_calc_screen.dart';
import 'package:trafficutilities/screens/lams_screen.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  static const String APP_TITLE = 'Traffic Utilties';
  static const String APP_VERSION = '1.0';
  static String emailAddress = "email address";
  static String fullName = "User Name";

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountEmail: Text(emailAddress),
      accountName: Text(fullName),
      currentAccountPicture: CircleAvatar(
        child: Image.asset(
          'images/logo.png',
          height: 42.0,
          width: 42.0,
        ),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Offence Search System'),
          onTap: () {
            //Navigator.pushNamed(context, OffenceSearchScreen.id);
          },
        ),
        ListTile(
          title: Text('Breath Test Calculator'),
          onTap: () {
            Navigator.pushNamed(context, BreathCalcScreen.id);
          },
        ),
        ListTile(
          title: Text('Vehicle Rego Checks'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Temp Movement Permit Search'),
          onTap: () {
            //Navigator.pushNamed(context, TempPermitSearchScreen.id);
          },
        ),
        ListTile(
          title: Text('L.A.M.S. Info'),
          onTap: () {
            Navigator.pushNamed(context, LAMSScreen.id);
          },
        ),
        Divider(),
        ListTile(
          title: Text('My Profile'),
          onTap: () {},
        ),
        ListTile(
          title: Text('My Links'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
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
    return drawerItems;
  }
}

//final drawerHeader = UserAccountsDrawerHeader(
//    accountName: Text('User Name'),
//    accountEmail: Text('Email Address'),
//    currentAccountPicture: CircleAvatar(
//    child: Image.asset('images/logo.png', height: 42.0, width: 42.0),
//    backgroundColor: Colors.white,
//    ),
//    );
//    final drawerItems = ListView(
//    children: <Widget>[
//    drawerHeader,

//    );
//    // End Nav Drawer
