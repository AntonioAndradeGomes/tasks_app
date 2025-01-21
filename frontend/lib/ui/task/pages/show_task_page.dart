import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:frontend/ui/task/widgets/task_editable_body_widget.dart';

class ShowTaskPage extends StatefulWidget {
  final String? taskId;
  const ShowTaskPage({
    super.key,
    this.taskId,
  });

  @override
  State<ShowTaskPage> createState() => _ShowTaskPageState();
}

class _ShowTaskPageState extends State<ShowTaskPage> {
  //final _formKey = GlobalKey<FormState>();
  late ShowTaskViewmodel _showTaskViewmodel;

  @override
  void initState() {
    _showTaskViewmodel = getIt<ShowTaskViewmodel>();
    _showTaskViewmodel.loadTask.execute(widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListenableBuilder(
          listenable: _showTaskViewmodel.loadTask,
          builder: (_, child) {
            if (_showTaskViewmodel.loadTask.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (_showTaskViewmodel.loadTask.error) {
              return Center(
                child: Text(
                  _showTaskViewmodel.loadTask.error.toString(),
                ),
              );
            }
            return child!;
          },
          child: TaskEditableBodyWidget(
            showTaskViewmodel: _showTaskViewmodel,
          ),
        ),
      ),
    );
  }
}
