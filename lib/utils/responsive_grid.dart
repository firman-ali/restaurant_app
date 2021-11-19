import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final SliverGrid mobile;
  final SliverGrid web;
  final SliverGrid tab;

  const ResponsiveGrid(
      {Key? key, required this.mobile, required this.web, required this.tab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 600) {
        return mobile;
      } else if (constraint.maxWidth <= 900) {
        return tab;
      } else {
        return web;
      }
    });
  }
}
