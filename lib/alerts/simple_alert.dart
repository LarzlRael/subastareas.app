import 'package:flutter/material.dart';

void showSimpleAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informacion incorrecta'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'), onPressed: () => Navigator.pop(context)),
          ],
        );
      });
}
