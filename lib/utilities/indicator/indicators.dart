import 'package:flutter/material.dart';

class Indicator {
  static loading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  static popIndicator(BuildContext context) {
    Navigator.pop(context);
  }
}
