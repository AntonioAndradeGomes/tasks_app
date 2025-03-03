import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/routing/routes.dart';
import 'package:go_router/go_router.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onPressed;
  final ConfirmDismissCallback? confirmDismiss;
  const TaskCard({
    super.key,
    required this.task,
    this.onPressed,
    this.confirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final completed = task.completedAt != null;
    return Dismissible(
      key: ValueKey(task.id),
      confirmDismiss: confirmDismiss,
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: task.hexColor != null
                ? hexToColor(task.hexColor!)
                : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              context.push(Routes.taskWithId(task.id!));
            },
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
                    Expanded(
                      child: Text(
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
                    ),
                  ],
                ),
                task.description != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 5,
                          right: 5,
                        ),
                        child: Text(
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
                        ),
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
