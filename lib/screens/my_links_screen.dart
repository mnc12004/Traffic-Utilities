import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficutilities/components/rounded_button.dart';

import 'web_rego_check.dart';

class MyLinksScreen extends StatefulWidget {
  static const String id = 'my_links_screen';
  @override
  _MyLinksScreenState createState() => _MyLinksScreenState();
}

class _MyLinksScreenState extends State<MyLinksScreen> {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Firestore _db = Firestore.instance;
  CollectionReference _lnkref = _db.collection('myLinks');
  FirebaseUser user;
  String error;

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
    });
  }

  void _showDialog() {
    
    String url;
    String title;

    final _urlConrtroller = TextEditingController(text: 'https://');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Add New Web Link"),
          content: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Link Title',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: _urlConrtroller,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Web Address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      url = value;
                    });
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.orange,
                  title: 'Add Link',
                  onPressed: () {
                    var myUrl = url;
                    var myTitle = title;
                    var myUid = user.uid;
                    Firestore.instance.collection('myLinks').document().setData(
                        {'title': myTitle, 'url': myUrl, 'uid': myUid});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
   
    super.initState();
    _auth.currentUser().then(setUser).catchError(setError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Links'),
        centerTitle: true,
      ),
      body: user != null ? _linkStream(context) : Text('Error: $error'),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () {
          _showDialog();
        },
      ),
    );
  }

  Widget _linkStream(BuildContext context) {
    print('User ID: ${user.uid}');
    return StreamBuilder<QuerySnapshot>(
        stream: _lnkref
            .where("uid", isEqualTo: "${user.uid}")
            .orderBy('title')
            .snapshots(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: new Text(
                'Loading...',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ));
            case ConnectionState.active:
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Card(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    color: Colors.blue[800],
                    elevation: 10.0,
                    child: Dismissible(
                      key: Key(document.documentID),
                      direction: DismissDirection.endToStart,
                      onDismissed: (dismiss) {
                        setState(() {
                          Firestore.instance
                              .collection('myLinks')
                              .document(document.documentID)
                              .delete();
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('My Link removed!'),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.trashAlt,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          var url = document['url'];
                          var title = document['title'];
                          print('Title: $title');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebRegoCheck(
                                url: url,
                                title: title,
                              ),
                            ),
                          );
                        },
                        title: new Text(
                          document['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: new Text(document['url'],
                            style: TextStyle(color: Colors.white70)),
                        leading: Icon(
                          FontAwesomeIcons.globe,
                          color: Colors.white,
                        ),
                        trailing: Icon(FontAwesomeIcons.arrowRight,
                            color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              );
            case ConnectionState.none:
              
              break;
            case ConnectionState.done:
              
              break;
          }
        });
  }
}
