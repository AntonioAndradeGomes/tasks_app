import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:frontend/ui/task/widgets/task_editable_body_widget.dart';
import 'package:go_router/go_router.dart';

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
        appBar: AppBar(),
        body: ListenableBuilder(
          listenable: Listenable.merge(
              [_showTaskViewmodel.loadTask, _showTaskViewmodel.deleteTask]),
          builder: (_, child) {
            if (_showTaskViewmodel.loadTask.running ||
                _showTaskViewmodel.deleteTask.running) {
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
          child: ListenableBuilder(
            listenable: _showTaskViewmodel.saveTask,
            builder: (context, child) {
              return TaskEditableBodyWidget(
                showTaskViewmodel: _showTaskViewmodel,
                running: _showTaskViewmodel.saveTask.running,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _resultSave() async {
    if (_showTaskViewmodel.saveTask.completed) {
      _showTaskViewmodel.saveTask.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task saved'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_showTaskViewmodel.saveTask.error) {
      _showTaskViewmodel.saveTask.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resultDelete() async {
    if (_showTaskViewmodel.deleteTask.completed) {
      _showTaskViewmodel.saveTask.clearResult();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task deleted'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_showTaskViewmodel.deleteTask.error) {
      _showTaskViewmodel.saveTask.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleted task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
