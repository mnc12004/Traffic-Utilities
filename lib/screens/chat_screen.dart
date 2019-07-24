import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trafficutilities/constants.dart';

final _db = Firestore.instance;
FirebaseUser loggedInUSer;
ScrollController _scrollController;
bool _isOnTop = true;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String fullName = 'User';
  String emailAddress = 'Email';

  static final FirebaseDatabase database = FirebaseDatabase();
  DatabaseReference reference = database.reference().child('users');

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _scrollController = ScrollController();
  }

    @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    setState(() => _isOnTop = true);
  }

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    setState(() => _isOnTop = false);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUSer = user;
        String uid = loggedInUSer.uid;
        setState(() {
          reference.child(uid).once().then((DataSnapshot snap) {
            var name = snap.value['full_name'];
            var email = snap.value['email'];

            fullName = name;
            emailAddress = email;
            print(fullName);
            print(emailAddress);
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void streamMessages() async {
    await for (var snapshot in _db.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Traffic ️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _db.collection('messages').add({
                        'body': messageText,
                        'sender': loggedInUSer.email,
                        'sendId': loggedInUSer.uid,
                        'fullName': fullName != null
                            ? fullName
                            : loggedInUSer.displayName != null
                                ? loggedInUSer.displayName
                                : Text('Chat User'),
                        'sent': DateTime.now()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(alignment: Alignment.centerRight, heightFactor: 50.0,
              child: FloatingActionButton(onPressed: _isOnTop ? _scrollToBottom : _scrollToTop,
            child: Icon(_isOnTop ? Icons.arrow_downward : Icons.arrow_upward),
          ),
      )
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
              strokeWidth: 1.0,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['body'];
          final messageSender = message.data['sender'];
          final messageSenderName = message.data['fullName'];

          final currentUser = loggedInUSer.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            fullName: messageSenderName,
            body: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1), BlendMode.dstATop),
              ),
            ),
            child: ListView(
              controller: _scrollController,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.body, this.sender, this.fullName, this.isMe});

  final String sender;
  final String fullName;
  final String body;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text('$fullName said...',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey[600],
              )),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 10.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                body,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
