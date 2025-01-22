import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/routing/routes.dart';
import 'package:go_router/go_router.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onPressed;
  const TaskCard({
    super.key,
    required this.task,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final completed = task.completedAt != null;
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color:
              task.hexColor != null ? hexToColor(task.hexColor!) : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
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
                      onPressed: onPressed,
                      iconSize: 25,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        !completed ? Icons.circle_outlined : Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration:
                            completed ? TextDecoration.lineThrough : null,
                        decorationColor: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                task.description != null
                    ? Text(
                        task.description ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration:
                              completed ? TextDecoration.lineThrough : null,
                          decorationColor: Colors.white,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
