import 'package:flutter/material.dart';

class CustomDialog {
  static showCustomDialog(
      BuildContext context, String title, String description) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        content: Text(description,
            style: const TextStyle(
              fontSize: 18,
            )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK',
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
        ],
      ),
    );
  }
}
