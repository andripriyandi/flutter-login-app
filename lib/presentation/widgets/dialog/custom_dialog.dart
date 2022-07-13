import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onTap;

  const CustomDialog(
      {Key? key, required this.title, required this.message, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _showIOSDialog(context)
        : _showAndroidDialog(context);
  }

  CupertinoAlertDialog _showIOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: title != "" ? Text(title) : null,
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: onTap ?? () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        )
      ],
    );
  }

  AlertDialog _showAndroidDialog(BuildContext context) {
    return AlertDialog(
      title: title != "" ? Text(title) : null,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onTap ?? () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        )
      ],
    );
  }
}
