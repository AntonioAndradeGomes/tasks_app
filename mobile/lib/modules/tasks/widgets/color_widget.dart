import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';

class ColorWidget extends StatelessWidget {
  final String color;
  final bool isSelected;
  final GestureTapCallback? onTap;
  const ColorWidget({
    super.key,
    required this.color,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: hexToColor(color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: isSelected
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
