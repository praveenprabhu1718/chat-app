import 'package:chat_app/app/custom_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class EmailSignInButton extends CustomRaisedButton {
  EmailSignInButton({
    String title,
    Color color,
    Color titleColor,
    VoidCallback onPressed,
    double radius,
  }) : super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.email_outlined, size: 36,),
                Text(
                  title,
                  style: TextStyle(fontSize: 15, color: titleColor),
                ),
                Opacity(
                  opacity: 0,
                  child: Icon(Icons.email_outlined),
                ),
              ],
            ),
            color: color,
            onPressed: onPressed,
            radius: radius);
}
