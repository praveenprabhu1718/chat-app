import 'file:///D:/Praveen/Android/chat_app/lib/app/pages/chat/chat_page.dart';
import 'package:chat_app/app/pages/login/login_page.dart';
import 'package:chat_app/app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: auth.onStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          EndUser user = snapshot.data;
          if (user == null) {
            print('null');
            return LoginPage.create(context);
          } else {
            return ChatPage();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
