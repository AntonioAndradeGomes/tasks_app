import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';

import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:frontend/ui/task/widgets/select_color_widget.dart';
import 'package:frontend/ui/task/widgets/select_due_date_widget.dart';

class TaskEditableBodyWidget extends StatelessWidget {
  final ShowTaskViewmodel showTaskViewmodel;
  final bool running;
  const TaskEditableBodyWidget({
    super.key,
    required this.showTaskViewmodel,
    required this.running,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ListenableBuilder(
      listenable: showTaskViewmodel,
      builder: (context, child) {
        if (showTaskViewmodel.task == null) {
          return const SizedBox();
        }
        final task = showTaskViewmodel.task!;
        final color =
            task.hexColor != null ? hexToColor(task.hexColor!) : Colors.grey;
        final completed = task.completedAt == null;
        final focusBorder = task.hexColor != null
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: color,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null;
        return Form(
          key: formKey,
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
                      onPressed:
                          running ? null : showTaskViewmodel.setCompletedAt,
                      iconSize: 35,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        completed ? Icons.circle_outlined : Icons.check_circle,
                        color: color,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: running,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Título',
                          focusedBorder: focusBorder,
                        ),
                        maxLines: null,
                        initialValue: task.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Título obrigatório";
                          }
                          return null;
                        },
                        onChanged: showTaskViewmodel.setTitle,
                      ),
                    ),
                    if (task.id != null)
                      IconButton(
                        onPressed: running
                            ? null
                            : showTaskViewmodel.deleteTask.execute,
                        icon: const Icon(
                          Icons.delete,
                        ),
                      )
                  ],
                ),
                TextFormField(
                  readOnly: running,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    focusedBorder: focusBorder,
                  ),
                  onChanged: showTaskViewmodel.setDescription,
                  maxLines: 4,
                  initialValue: showTaskViewmodel.task!.description,
                ),
                SelectDueDateWidget(
                  disabled: running,
                  selectedColor: color,
                  dueAt: task.dueAt,
                  onChanged: showTaskViewmodel.setDueAt,
                ),
                SelectColorWidget(
                  selectColor: task.hexColor,
                  disabled: running,
                  onChanged: showTaskViewmodel.setHexColor,
                ),
                if (showTaskViewmodel.taskWasEdited)
                  running
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(color),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (formKey.currentState!.validate()) {
                              showTaskViewmodel.saveTask.execute();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                          ),
                          child: const Text(
                            'Salvar alterações',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
              ],
            ),
          ),
        );
      },
    );
  }
}
