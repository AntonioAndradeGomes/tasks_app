import 'package:flutter/material.dart';

Color hexToColor(String hexCode) {
  final hex = hexCode.replaceAll('#', '');
  return Color(int.parse('ff$hex', radix: 16));
}
