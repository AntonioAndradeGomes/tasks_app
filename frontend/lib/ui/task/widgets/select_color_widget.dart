import 'package:flutter/material.dart';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/ui/task/widgets/color_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectColorWidget extends StatelessWidget {
  final String? selectColor;
  final ValueChanged<String>? onChanged;
  final bool disabled;
  const SelectColorWidget({
    super.key,
    required this.selectColor,
    this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      initialValue: selectColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (color) {
        if (color == null) {
          return AppLocalizations.of(context)!.mandatory_color;
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.change_color,
              style: const TextStyle(
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
                    (color) => ColorWidget(
                      color: color,
                      isSelected: selectColor == color,
                      onTap: disabled
                          ? null
                          : () {
                              if (onChanged != null) {
                                onChanged!(color);
                              }
                              state.didChange(color);
                            },
                    ),
                  )
                  .toList(),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
