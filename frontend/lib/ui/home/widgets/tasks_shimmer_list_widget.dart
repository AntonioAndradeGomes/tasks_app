import 'package:flutter/material.dart';
import 'package:frontend/ui/home/widgets/task_shimmer_card.widget.dart';

class TasksShimmerListWidget extends StatelessWidget {
  const TasksShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        bottom: 150,
        top: 10,
        left: 10,
        right: 10,
      ),
      itemCount: 15,
      itemBuilder: (_, __) => const TaskShimmerCardWidget(),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
