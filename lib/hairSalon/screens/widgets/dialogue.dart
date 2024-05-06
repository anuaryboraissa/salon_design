import 'package:flutter/material.dart';

appDialog(
    BuildContext context, String message) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      content: ListTile(
        leading: const CircularProgressIndicator(),
        title: Text(message),
      ),
    ),
  );
}
