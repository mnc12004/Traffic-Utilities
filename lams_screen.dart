import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _db = Firestore.instance;
FirebaseUser loggedInUser;

class LAMSScreen extends StatefulWidget {
  static const String id = 'lamms_screen';
  @override
  _LAMSScreenState createState() => _LAMSScreenState();
}

class _LAMSScreenState extends State<LAMSScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String make;
  String imgUrl;
  String model;

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('L.A.M.S.'),
        centerTitle: true,
      ),
      body: LAMSList(),
    );
  }
}

class LAMSList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _db.collection('lams').orderBy('brand').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  color: Colors.blue[800],
                  elevation: 10.0,
                  child: new ListTile(
                    title: new Text(
                      document['brand'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: new Text(
                      document['model'],
                      style: TextStyle(color: Colors.white70),
                    ),
                    leading: new Image(
                      image: NetworkImage(document.data['image'].toString()),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
