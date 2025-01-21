import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/routing/routes.dart';
import 'package:go_router/go_router.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final completed = task.completedAt != null;
    return Ink(
      decoration: BoxDecoration(
        color: hexToColor(task.hexColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          context.push(Routes.taskWithId(task.id!));
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      !completed ? Icons.circle_outlined : Icons.check_circle,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              task.description != null
                  ? Text(
                      task.description ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
