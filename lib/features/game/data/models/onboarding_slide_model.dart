import 'package:flutter/material.dart';

class OnboardingSlide {
  final String icon;
  final String title;
  final String description;
  final List<String>? features;
  final Color color;
  final bool isShaking;
  final bool isLast;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    this.features,
    required this.color,
    this.isShaking = false,
    this.isLast = false,
  });
}
