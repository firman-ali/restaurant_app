import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';

Widget profileRow(BuildContext context) {
  return Row(
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 0.5)),
        child: const Icon(
          CupertinoIcons.person_fill,
          color: Colors.black45,
          size: 30,
        ),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(DataString.welcome),
          Text(
            DataString.userHome,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      )
    ],
  );
}
