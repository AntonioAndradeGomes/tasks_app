import 'package:flutter/material.dart';
import 'package:frontend/core/helpers/colors.dart';
import 'package:frontend/domain/models/task_model.dart';
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
    final formKey = GlobalKey<FormState>();
    return ListenableBuilder(
      listenable: showTaskViewmodel,
      builder: (context, child) {
        final color = showTaskViewmodel.task != null
            ? hexToColor(showTaskViewmodel.task!.hexColor)
            : Colors.grey;
        final completed = showTaskViewmodel.task!.completedAt == null;
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
                      onPressed: showTaskViewmodel.completeTask,
                      iconSize: 35,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        completed ? Icons.circle_outlined : Icons.check_circle,
                        color: color,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Título',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: color,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxLines: null,
                        initialValue: showTaskViewmodel.task!.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Título obrigatório";
                          }
                          return null;
                        },
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
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: color,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                  onTap: () async {
                    final data = await showDatePicker(
                      context: context,
                      currentDate: DateTime.now(),
                      helpText: "Selecionar a data de conclusão da tarefa",
                      initialDate:
                          showTaskViewmodel.task!.dueAt ?? DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2100),
                    );
                    if (data != null) {
                      showTaskViewmodel.updateDueDate(data);
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
                            Icons.edit_calendar,
                            color: showTaskViewmodel.task!.dueAt != null
                                ? color
                                : Colors.grey,
                          ),
                          Text(
                            showTaskViewmodel.task!.dueAt != null
                                ? 'Para ${showTaskViewmodel.task!.formattedDueAt()!}'
                                : 'Adicionar data de conclusão',
                            style: TextStyle(
                              color: showTaskViewmodel.task!.dueAt != null
                                  ? color
                                  : Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      if (showTaskViewmodel.task!.dueAt != null)
                        InkWell(
                          onTap: () {
                            showTaskViewmodel.updateDueDate(null);
                          },
                          child: Icon(
                            Icons.close,
                            color: hexToColor(showTaskViewmodel.task!.hexColor),
                          ),
                        )
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                        ),
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
