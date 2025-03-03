import 'package:flutter/material.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/ui/home/widgets/concluded_card_tap_widget.dart';
import 'package:frontend/ui/home/widgets/task_card.dart';

class HomeBodyPageWidget extends StatefulWidget {
  final HomeViewModel homeViewModel;
  const HomeBodyPageWidget({
    super.key,
    required this.homeViewModel,
  });

  @override
  State<HomeBodyPageWidget> createState() => _HomeBodyPageWidgetState();
}

class _HomeBodyPageWidgetState extends State<HomeBodyPageWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.homeViewModel,
      builder: (_, __) {
        final items = widget.homeViewModel.tasks;
        if (items.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.no_task,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () {
            return widget.homeViewModel.load.execute();
          },
          child: ListView(
            padding: const EdgeInsets.only(
              bottom: 150,
              top: 10,
              left: 10,
              right: 10,
            ),
            children: [
              ...widget.homeViewModel.uncompletedTasks.map(
                (task) => TaskCard(
                  task: task,
                  onPressed: () =>
                      widget.homeViewModel.updateTask.execute(task),
                  confirmDismiss: (direction) async {
                    await widget.homeViewModel.deleteTask.execute(task.id!);
                    if (widget.homeViewModel.deleteTask.isSuccess) {
                      return true;
                    }
                    return false;
                  },
                ),
              ),
              if (widget.homeViewModel.completedTasks.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConcludedCardTapWidget(
                      isOpen: widget.homeViewModel.showCompleted,
                      onTap: () {
                        widget.homeViewModel.showCompleted =
                            !widget.homeViewModel.showCompleted;
                      },
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      child: widget.homeViewModel.showCompleted
                          ? Column(
                              children: widget.homeViewModel.completedTasks
                                  .map(
                                    (task) => TaskCard(
                                      task: task,
                                      onPressed: () => widget
                                          .homeViewModel.updateTask
                                          .execute(task),
                                      confirmDismiss: (direction) async {
                                        await widget.homeViewModel.deleteTask
                                            .execute(task.id!);
                                        if (widget.homeViewModel.deleteTask
                                            .isSuccess) {
                                          return true;
                                        }
                                        return false;
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
