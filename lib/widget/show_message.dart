import 'package:flutter/material.dart';

Widget showMessage(BuildContext context, String message) {
  return Center(
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline4,
    ),
  );
}
