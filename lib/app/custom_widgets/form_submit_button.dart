import 'package:chat_app/app/custom_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    String text,
    VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    color: Colors.green,
    onPressed: onPressed,
  );
}
