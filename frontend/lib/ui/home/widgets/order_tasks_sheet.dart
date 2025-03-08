import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:go_router/go_router.dart';

class OrderTasksSheet extends StatelessWidget {
  const OrderTasksSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final usesOrderBy = [OrderBy.title, OrderBy.completedAt, OrderBy.createdAt];
    return Container(
      /*margin: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),*/
      padding: EdgeInsets.only(
        top: 6,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.sort,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: context.pop,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 6,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: usesOrderBy
                .map(
                  (e) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    dense: true,
                    leading: Icon(e.icon),
                    title: Text(
                      e.label(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {},
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
