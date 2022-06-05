import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  late String textMessage;
  String prevMsg = 'noUser';

  void scrollToBottom() {
    Timer _timer = new Timer(Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Global Chat',style: TextStyle(color: Color(0xffDBE6FC)),),
        backgroundColor: Color(0xff3e4785),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bck5.jpg'), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('timestamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    scrollToBottom();
                    var documents = snapshot.data!.docs;
                    List<MessageBubble> MessageBubbles = [];
                    for (var doc in documents) {
                      var message = doc['text'];
                      var sender = doc['sender'];
                      var messageBubble = MessageBubble(
                        sender: sender,
                        message: message,
                        isMe: sender == loggedInUser.email,
                        sameLastSender: sender == prevMsg,
                      );
                      MessageBubbles.add(messageBubble);
                      prevMsg = doc['sender'];
                    }
                    return Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: MessageBubbles,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlueAccent,
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 3),
                child: Material(
                  color: Color(0xff3e4785),
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            onChanged: (value) {
                              textMessage = value;
                              //Do something with the user input.
                            },
                            style: TextStyle(color: Color(0xffDBE6FC)),
                            decoration: InputDecoration(
                              hintText: 'Type your message here...',
                              hintStyle: TextStyle(color: Color(0xffDBE6FC)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeOut,
                            );
                            messageController.clear();
                            _firestore.collection('messages').add({
                              'text': textMessage,
                              'sender': loggedInUser.email,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                            //Implement send functionality.
                          },
                          color: Color(0xffDBE6FC),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true),size: 35,),
                          ),
                          minWidth: 0,
                          shape: CircleBorder(),
                          // child: Material(
                          //   color: Color(0xffDBE6FC),
                          //   borderRadius: BorderRadius.circular(10),
                          //   child: Icon(IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true),size: 35,),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message, sender;
  final bool isMe, sameLastSender;
  MessageBubble(
      {required this.message,
      required this.sender,
      required this.isMe,
      required this.sameLastSender});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          !sameLastSender
              ? Text(
                  sender,
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                )
              : Container(),
          Material(
            elevation: 5.0,
            borderRadius: sameLastSender
                ? BorderRadius.circular(30)
                : isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))
                    : BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
            color: isMe ? Color(0xff3e4785) : Color(0xffDBE6FC),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 16.0,
                    color: isMe ? Color(0xffDBE6FC) : Color(0xff3e4785)),
                // textAlign: sender == loggedInUser.email
                //     ? TextAlign.right
                //     : TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
