import 'package:flutter/material.dart';

class CustomSnackbar {
  static show(
    context, {
    message,
    seconds = 3,
    fixed = true,
    color = Colors.green,
  }) {
    //f (color == null) color = Theme.of(context).primaryColor;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: seconds),
        behavior: fixed ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
      ),
    );
  }

  static showError(
    context, {
    message,
    seconds = 3,
    fixed = true,
    color = Colors.redAccent,
  }) {
    //if (color == null) color = Theme.of(context).primaryColor;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: seconds),
        behavior: fixed ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
      ),
    );
  }
}
