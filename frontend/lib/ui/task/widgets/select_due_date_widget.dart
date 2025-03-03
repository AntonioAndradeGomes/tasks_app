import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectDueDateWidget extends StatelessWidget {
  final DateTime? dueAt;
  final ValueChanged<DateTime?>? onChanged;
  final Color? selectedColor;
  final bool disabled;
  const SelectDueDateWidget({
    super.key,
    this.dueAt,
    this.onChanged,
    required this.selectedColor,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled
          ? null
          : () async {
              final data = await showDatePicker(
                context: context,
                currentDate: DateTime.now(),
                helpText: AppLocalizations.of(context)!.due_at_help_text,
                initialDate: dueAt ?? DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2100),
              );
              if (data != null && onChanged != null) {
                onChanged!(data);
              }
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 10,
            children: [
              Icon(
                Icons.calendar_month,
                color: selectedColor != null && dueAt != null
                    ? selectedColor
                    : Colors.grey,
              ),
              Text(
                dueAt != null
                    ? DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(dueAt!)
                    : AppLocalizations.of(context)!.due_at,
                style: TextStyle(
                  color: selectedColor != null && dueAt != null
                      ? selectedColor
                      : Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          if (dueAt != null)
            InkWell(
              onTap: () {
                if (onChanged != null) {
                  onChanged!(null);
                }
              },
              child: Icon(
                Icons.close,
                color: selectedColor,
              ),
            ),
        ],
      ),
    );
  }
}
