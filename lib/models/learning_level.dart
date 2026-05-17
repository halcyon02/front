import 'package:flutter/material.dart';

class LearningLevel {
  final String id;
  final String title;
  final String subtitle;
  final double progress;
  final bool unlocked;
  final Color accentColor;
  final List<bool> dots;

  const LearningLevel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.unlocked,
    required this.accentColor,
    required this.dots,
  });
}