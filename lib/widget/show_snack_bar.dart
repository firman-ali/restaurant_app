import 'package:flutter/material.dart';

SnackBar showSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
  );
}
