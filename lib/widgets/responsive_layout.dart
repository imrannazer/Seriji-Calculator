import 'package:flutter/material.dart';

enum LayoutClass { compact, medium, expanded }

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  final Widget compact;
  final Widget? medium;
  final Widget? expanded;

  static LayoutClass of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return LayoutClass.expanded;
    if (width >= 600) return LayoutClass.medium;
    return LayoutClass.compact;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200 && expanded != null) {
          return expanded!;
        }
        if (constraints.maxWidth >= 600 && medium != null) {
          return medium!;
        }
        return compact;
      },
    );
  }
}
