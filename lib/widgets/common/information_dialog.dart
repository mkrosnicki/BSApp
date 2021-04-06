import 'package:flutter/material.dart';

Future<void> showInformationDialog(
  BuildContext context,
  Widget title,
  Widget content,
  Widget textOK,
) async {
  await showDialog<bool>(
    context: context,
    builder: (_) => WillPopScope(
      child: AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            child: textOK,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
  );
}
