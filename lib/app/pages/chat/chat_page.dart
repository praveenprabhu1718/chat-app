import 'package:chat_app/app/custom_widgets/platform_alert_dialog.dart';
import 'package:chat_app/app/pages/chat/message.dart';
import 'package:chat_app/app/pages/chat/message_bubble.dart';
import 'package:chat_app/app/services/auth.dart';
import 'package:chat_app/app/services/firestore_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirestoreDatabase _database = FirestoreDatabase();

  final _messageTextController = TextEditingController();

  EndUser loggedInUser;

  String _messageText;

  final _sendButtonTextStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  final _messageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );

  final _messageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    final user = Provider.of<AuthBase>(context, listen: false);
    loggedInUser = await user.getCurrentUser();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    bool didSignOutConfirmed = await PlatformAlertDialog(
      cancelActionText: 'Cancel',
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      defaultActionText: 'Logout',
    ).show(context);
    if (didSignOutConfirmed) {
      await _signOut(context);
    }
  }

  Widget _messageStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: _database.getMessages(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        return Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: snapshot.data.docs.reversed.map((doc) {
              Message message = Message.fromMap(doc);
              return MessageBubble(
                sender: message.email,
                text: message.text,
                isMe: message.email == loggedInUser.email,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _messageStream(),
          Container(
            decoration: _messageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    onChanged: (value) {
                      _messageText = value;
                    },
                    decoration: _messageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    await _database.sendMessage(
                      Message(
                          text: _messageTextController.text,
                          email: loggedInUser.email),
                    );
                    _messageTextController.clear();
                  },
                  child: Text(
                    'Send',
                    style: _sendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.login_outlined),
                onPressed: () => _confirmSignOut(context))
          ],
        ),
        body: _buildContent());
  }
}
