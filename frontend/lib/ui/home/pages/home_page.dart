import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/data/exceptions/http_unauthorized_exception.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/logout/widgets/logout_widget.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:frontend/ui/home/widgets/concluded_card_tap_widget.dart';
import 'package:frontend/ui/home/widgets/task_card.dart';
import 'package:frontend/ui/home/widgets/tasks_shimmer_list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:result_command/result_command.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    _homeViewModel = getIt<HomeViewModel>();

    _homeViewModel.deleteTask.addListener(_resultDelete);
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.deleteTask.removeListener(_resultDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.my_tasks),
        forceMaterialTransparency: true,
        actions: const [
          LogoutWidget(),
        ],
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _homeViewModel.load,
        builder: (_, child) {
          if (_homeViewModel.load.isSuccess) {
            return child!;
          }
          return const SizedBox();
        },
        child: FloatingActionButton(
          onPressed: () => context.push(Routes.task),
          tooltip: AppLocalizations.of(context)!.add_task,
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _homeViewModel.load,
          builder: (_, child) {
            if (_homeViewModel.load.isRunning) {
              return const TasksShimmerListWidget();
            }
            if (_homeViewModel.load.isFailure) {
              /*if (((_homeViewModel.load.value as FailureCommand).error
                  is HttpUnauthorizedException)) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Você não está autenticado!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }*/
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Erro ao carregar as tarefas!',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: _homeViewModel.load.execute,
                      child: const Text(
                        'Tente novamente',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
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
                    'Sem tarefas!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
                        onPressed: () =>
                            _homeViewModel.updateTask.execute(task),
                        confirmDismiss: (direction) async {
                          await _homeViewModel.deleteTask.execute(task.id!);
                          if (_homeViewModel.deleteTask.isSuccess) {
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
                          ConcludedCardTapWidget(
                            isOpen: _homeViewModel.showCompleted,
                            onTap: () {
                              _homeViewModel.showCompleted =
                                  !_homeViewModel.showCompleted;
                            },
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
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
                                                  .deleteTask.isSuccess) {
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
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _resultDelete() async {
    if (_homeViewModel.deleteTask.isSuccess) {
      _homeViewModel.deleteTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task Deleted'),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (_homeViewModel.deleteTask.isFailure) {
      _homeViewModel.deleteTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleting task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
