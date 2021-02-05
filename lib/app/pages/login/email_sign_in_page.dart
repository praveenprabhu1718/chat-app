

import 'package:chat_app/app/pages/login/email_sign_in_form.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Time Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: EmailSignInForm.create(context),
          ),
        ),
      ),
    );
  }
}
