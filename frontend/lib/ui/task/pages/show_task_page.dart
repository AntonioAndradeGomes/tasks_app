import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:frontend/ui/task/widgets/task_editable_body_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:result_dart/result_dart.dart';

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
  late ShowTaskViewmodel _showTaskViewmodel;

  @override
  void initState() {
    _showTaskViewmodel = getIt<ShowTaskViewmodel>();
    _showTaskViewmodel.loadTask.execute(widget.taskId);
    _showTaskViewmodel.saveTask.addListener(_resultSave);
    _showTaskViewmodel.deleteTask.addListener(_resultDelete);
    super.initState();
  }

  @override
  void dispose() {
    _showTaskViewmodel.saveTask.removeListener(_resultSave);
    _showTaskViewmodel.deleteTask.removeListener(_resultDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: SafeArea(
          child: ListenableBuilder(
            listenable: Listenable.merge(
                [_showTaskViewmodel.loadTask, _showTaskViewmodel.deleteTask]),
            builder: (_, child) {
              if (_showTaskViewmodel.loadTask.isRunning ||
                  _showTaskViewmodel.deleteTask.isRunning) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (_showTaskViewmodel.loadTask.isFailure) {
                return Center(
                  child: Text(
                    _showTaskViewmodel.loadTask.toFailure().toString(),
                  ),
                );
              }
              return child!;
            },
            child: ListenableBuilder(
              listenable: _showTaskViewmodel.saveTask,
              builder: (context, child) {
                return TaskEditableBodyWidget(
                  showTaskViewmodel: _showTaskViewmodel,
                  running: _showTaskViewmodel.saveTask.isRunning,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resultSave() async {
    if (_showTaskViewmodel.saveTask.isSuccess) {
      _showTaskViewmodel.saveTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task saved'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_showTaskViewmodel.saveTask.isFailure) {
      _showTaskViewmodel.saveTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resultDelete() async {
    if (_showTaskViewmodel.deleteTask.isSuccess) {
      _showTaskViewmodel.saveTask.reset();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task deleted'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_showTaskViewmodel.deleteTask.isFailure) {
      _showTaskViewmodel.saveTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleted task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
