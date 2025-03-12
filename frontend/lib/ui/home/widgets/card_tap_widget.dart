import 'package:flutter/material.dart';

class CardTapWidget extends StatelessWidget {
  final bool isOpen;
  final GestureTapCallback? onTap;
  final VoidCallback? onCloseCallback;
  final IconData? iconClose;
  final String label;
  const CardTapWidget({
    super.key,
    required this.isOpen,
    this.onTap,
    required this.label,
    this.iconClose,
    this.onCloseCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: 0,
          color: Colors.grey.withAlpha(150),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_down_rounded
                        : iconClose ?? Icons.keyboard_arrow_right_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (onCloseCallback != null)
          IconButton(
            onPressed: onCloseCallback,
            icon: const Icon(
              Icons.close_rounded,
            ),
          )
      ],
    );
  }
}
