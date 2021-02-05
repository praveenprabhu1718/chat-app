import 'dart:io';

import 'package:chat_app/app/custom_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;

  PlatformAlertDialog(
      {@required this.title,
        @required this.content,
        this.cancelActionText,
        @required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => this,
    )
        : await showDialog<bool>(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];

    if (cancelActionText != null) {
      actions.add(PlatformAlertDialogAction(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(cancelActionText),
      ));
    }
    actions.add(PlatformAlertDialogAction(
      onPressed: () => Navigator.of(context).pop(true),
      child: Text(defaultActionText),
    ));
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({this.child, this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
