import 'package:flutter/material.dart';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/helpers/colors.dart';

class SelectColorWidget extends StatelessWidget {
  final String selectColor;
  final ValueChanged<String>? onChanged;
  const SelectColorWidget({
    super.key,
    required this.selectColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Selecionar cor',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 5,
          runSpacing: 10,
          children: Constants.colors
              .map(
                (color) => Ink(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: hexToColor(color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      if (onChanged != null) {
                        onChanged!(color);
                      }
                    },
                    child: selectColor == color
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
