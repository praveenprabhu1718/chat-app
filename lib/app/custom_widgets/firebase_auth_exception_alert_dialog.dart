import 'package:chat_app/app/custom_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthExceptionAlertDialog extends PlatformAlertDialog {
  FirebaseAuthExceptionAlertDialog({
    @required String title,
    @required FirebaseAuthException exception,
  }) : super(
      title: title,
      content: _message(exception),
      defaultActionText: 'OK'
  );

  static String _message(FirebaseAuthException exception){
    return exception.message;
  }

}
