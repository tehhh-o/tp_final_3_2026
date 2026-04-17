import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.black)),
        backgroundColor: isError ? Colors.red[50] : Colors.grey[50],
      ),
    );
  }
}
