import 'package:flutter/material.dart';
import 'package:predictiva_flutter/main.dart';

void showSnackbar(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
