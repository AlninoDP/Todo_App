import 'package:flutter/material.dart';

/// Allow to configure the data that we want to display
/// on Tap Bar or Navigation bar
class PageConfig {
  final IconData icon;
  final String name;
  final Widget child;

  const PageConfig({Widget? child, required this.icon, required this.name})
      : child =
            child ?? const Placeholder(); //if child isnt given, use placeholder
}
