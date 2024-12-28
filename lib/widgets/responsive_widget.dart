import 'package:flutter/material.dart';
import 'package:recipe_application/utils/breakpoints.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < Breakpoints.sm) {
          return mobile;
        } else if (constraints.maxWidth < Breakpoints.lg) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
