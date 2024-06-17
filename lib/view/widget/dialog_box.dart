import 'package:flutter/material.dart';

Future<void> showDialogBox(BuildContext context) async {



  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {

          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
