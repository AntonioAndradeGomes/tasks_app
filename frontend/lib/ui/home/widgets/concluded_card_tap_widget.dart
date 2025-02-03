import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConcludedCardTapWidget extends StatelessWidget {
  final bool isOpen;
  final GestureTapCallback? onTap;
  const ConcludedCardTapWidget({super.key, required this.isOpen, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
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
                  AppLocalizations.of(context)!.concluded,
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
                      : Icons.keyboard_arrow_right_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
