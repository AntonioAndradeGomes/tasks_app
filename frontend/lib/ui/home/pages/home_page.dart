import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/logout/logout_viewmodel.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:frontend/ui/home/widgets/task_card.dart';
import 'package:frontend/ui/home/widgets/tasks_shimmer_list_widget.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LogoutViewmodel _logoutViewModel;
  late HomeViewModel _homeViewModel;

  final ValueNotifier<bool> _showCompletedTasks = ValueNotifier<bool>(true);

  @override
  void initState() {
    _logoutViewModel = getIt<LogoutViewmodel>();
    _homeViewModel = getIt<HomeViewModel>();
    _logoutViewModel.logout.addListener(_resultLogout);
    _homeViewModel.deleteTask.addListener(_resultDelete);
    super.initState();
  }

  @override
  void dispose() {
    _showCompletedTasks.dispose();
    _logoutViewModel.logout.removeListener(_resultLogout);
    _homeViewModel.deleteTask.removeListener(_resultDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          ListenableBuilder(
            listenable: _logoutViewModel.logout,
            builder: (_, __) {
              if (_logoutViewModel.logout.running) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                onPressed: _logoutViewModel.logout.execute,
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _homeViewModel.load,
        builder: (_, child) {
          if (_homeViewModel.load.completed) {
            return child!;
          }
          return const SizedBox();
        },
        child: FloatingActionButton(
          onPressed: () => context.push(Routes.task),
          child: const Icon(Icons.add),
        ),
      ),
      body: ListenableBuilder(
        listenable: _homeViewModel.load,
        builder: (_, child) {
          if (_homeViewModel.load.running) {
            return const TasksShimmerListWidget();
          }
          if (_homeViewModel.load.error) {
            return const Center(
              child: Text(
                'Error loading tasks',
              ),
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: _homeViewModel,
          builder: (_, __) {
            final items = _homeViewModel.tasks;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'No tasks',
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                return _homeViewModel.load.execute();
              },
              child: ListView(
                padding: const EdgeInsets.only(
                  bottom: 150,
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                children: [
                  ..._homeViewModel.uncompletedTasks.map(
                    (task) => TaskCard(
                      task: task,
                      onPressed: () => _homeViewModel.updateTask.execute(task),
                      confirmDismiss: (direction) async {
                        await _homeViewModel.deleteTask.execute(task.id!);
                        if (_homeViewModel.deleteTask.completed) {
                          return true;
                        }
                        return false;
                      },
                    ),
                  ),
                  if (_homeViewModel.completedTasks.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 140,
                          child: Card(
                            elevation: 0,
                            color: Colors.grey.withAlpha(150),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                _homeViewModel.showCompleted =
                                    !_homeViewModel.showCompleted;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Concluded',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      //Icons.keyboard_arrow_right_rounded,
                                      _homeViewModel.showCompleted
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_right_rounded,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: _homeViewModel.showCompleted
                              ? Column(
                                  children: _homeViewModel.completedTasks
                                      .map(
                                        (task) => TaskCard(
                                          task: task,
                                          onPressed: () => _homeViewModel
                                              .updateTask
                                              .execute(task),
                                          confirmDismiss: (direction) async {
                                            await _homeViewModel.deleteTask
                                                .execute(task.id!);
                                            if (_homeViewModel
                                                .deleteTask.completed) {
                                              return true;
                                            }
                                            return false;
                                          },
                                        ),
                                      )
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                        ),
                        /*..._homeViewModel.completedTasks.map(
                              (task) => TaskCard(
                                task: task,
                                onPressed: () =>
                                    _homeViewModel.updateTask.execute(task),
                                confirmDismiss: (direction) async {
                                  await _homeViewModel.deleteTask
                                      .execute(task.id!);
                                  if (_homeViewModel.deleteTask.completed) {
                                    return true;
                                  }
                                  return false;
                                },
                              ),
                            ),*/
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _resultLogout() async {
    if (_logoutViewModel.logout.error) {
      _logoutViewModel.logout.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resultDelete() async {
    if (_homeViewModel.deleteTask.completed) {
      _logoutViewModel.logout.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task Deleted'),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (_homeViewModel.deleteTask.error) {
      _homeViewModel.deleteTask.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleting task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
