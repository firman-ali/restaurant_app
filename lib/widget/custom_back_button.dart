import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';

Widget backButton(BuildContext context) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(100)),
    child: TextButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        CupertinoIcons.back,
        size: 20,
        color: Colors.white,
      ),
      label: const Text(
        DataString.back,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  );
}
