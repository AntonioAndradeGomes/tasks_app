import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/logout/widgets/logout_widget.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:frontend/ui/home/widgets/home_body_page_widget.dart';
import 'package:frontend/ui/home/widgets/order_tasks_sheet.dart';
import 'package:frontend/ui/home/widgets/tasks_shimmer_list_widget.dart';
import 'package:go_router/go_router.dart';
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
    _homeViewModel.updateTask.addListener(_resultUpdate);
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.deleteTask.removeListener(_resultDelete);
    _homeViewModel.updateTask.removeListener(_resultUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.my_tasks,
        ),
        forceMaterialTransparency: true,
        actions: [
          const LogoutWidget(),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const OrderTasksSheet(),
              );
            },
            icon: const Icon(
              Icons.sort,
            ),
          )
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.error_tasks_load,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: _homeViewModel.load.execute,
                      child: Text(
                        AppLocalizations.of(context)!.try_again,
                        style: const TextStyle(
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
          child: HomeBodyPageWidget(
            homeViewModel: _homeViewModel,
          ),
        ),
      ),
    );
  }

  Future<void> _resultDelete() async {
    if (_homeViewModel.deleteTask.isSuccess) {
      _homeViewModel.deleteTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.task_deleted,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (_homeViewModel.deleteTask.isFailure) {
      _homeViewModel.deleteTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.task_deleted_error,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resultUpdate() async {
    if (_homeViewModel.updateTask.isSuccess) {
      _homeViewModel.updateTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.task_updated,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_homeViewModel.updateTask.isFailure) {
      _homeViewModel.updateTask.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.task_updated_error,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
