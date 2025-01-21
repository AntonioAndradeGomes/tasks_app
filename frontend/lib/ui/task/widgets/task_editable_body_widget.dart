import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:frontend/ui/task/widgets/select_color_widget.dart';

class TaskEditableBodyWidget extends StatelessWidget {
  final ShowTaskViewmodel showTaskViewmodel;
  const TaskEditableBodyWidget({
    super.key,
    required this.showTaskViewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: showTaskViewmodel,
      builder: (context, child) {
        return Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: showTaskViewmodel.completeTask,
                      iconSize: 35,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        showTaskViewmodel.task!.completedAt == null
                            ? Icons.circle_outlined
                            : Icons.check_circle,
                        color: hexToColor(showTaskViewmodel.task!.hexColor),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Título',
                        ),
                        maxLines: null,
                        initialValue: showTaskViewmodel.task!.title,
                        onChanged: (value) {
                          showTaskViewmodel.updateTask(
                            showTaskViewmodel.task!.copyWith(
                              title: value,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Descrição',
                  ),
                  onChanged: (value) {
                    showTaskViewmodel.updateTask(
                      showTaskViewmodel.task!.copyWith(
                        description: value,
                      ),
                    );
                  },
                  maxLines: 4,
                  initialValue: showTaskViewmodel.task!.description,
                ),
                InkWell(
                  onTap: () {},
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.edit_calendar,
                        color: Colors.grey,
                      ),
                      Text(
                        'Adicionar data de conclusão',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SelectColorWidget(
                  selectColor: showTaskViewmodel.task!.hexColor,
                  onChanged: (color) {
                    showTaskViewmodel.updateTask(
                      showTaskViewmodel.task!.copyWith(
                        hexColor: color,
                      ),
                    );
                  },
                ),
                showTaskViewmodel.taskWasEdited
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Salvar alterações',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
