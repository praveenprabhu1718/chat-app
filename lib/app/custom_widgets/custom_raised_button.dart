import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  final Widget child;
  final Color color;
  final double radius;
  final VoidCallback onPressed;

  const CustomRaisedButton({Key key, this.color, this.radius : 2.0, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(radius)
            )
        ),
        color: color,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
