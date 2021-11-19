import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tab;

  const ResponsiveWidget({Key? key, required this.mobile, required this.tab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 600) {
        return mobile;
      } else {
        return tab;
      }
    });
  }
}
