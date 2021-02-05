import 'package:chat_app/app/custom_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FacebookSignInButton extends CustomRaisedButton {
  FacebookSignInButton({
    String assetPath,
    String title,
    Color color,
    Color titleColor,
    VoidCallback onPressed,
    double radius,
  }) : super(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(assetPath),
          Text(
            title,
            style: TextStyle(fontSize: 15, color: titleColor),
          ),
          Opacity(opacity: 0, child: Image.asset(assetPath)),
        ],
      ),
      color: color,
      onPressed: onPressed,
      radius: radius);
}