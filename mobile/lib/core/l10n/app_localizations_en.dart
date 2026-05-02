// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_ => 'Login.';

  @override
  String get login => 'Login';

  @override
  String get signin => 'Sign in';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password';

  @override
  String get no_account => 'Don\'t have an account? ';

  @override
  String get signup => 'Sign up.';

  @override
  String get have_account => 'Already have an account? ';

  @override
  String get name => 'Name';

  @override
  String get register => 'Register';

  @override
  String get email_invalid => 'Invalid e-mail';

  @override
  String get field_required => 'This field is required';

  @override
  String get password_min => 'Password must be at least 6 characters long';

  @override
  String get unable_to_login => 'Unable to login';

  @override
  String get name_min => 'Name too short';

  @override
  String get registration_successful => 'Registration completed successfully!';

  @override
  String get registration_failed => 'Registration failed';

  @override
  String get my_tasks => 'My tasks';

  @override
  String get add_task => 'Add task';

  @override
  String get logout => 'Logout';

  @override
  String get concluded => 'Concluded';

  @override
  String get no_task => 'You don\'t have any tasks';

  @override
  String get error_tasks_load => 'Error loading tasks';

  @override
  String get try_again => 'Try again';

  @override
  String get task_deleted => 'Task deleted successfully!';

  @override
  String get task_deleted_error => 'Error deleting task!';

  @override
  String get task_updated => 'Task updated successfully!';

  @override
  String get task_updated_error => 'Error updating task!';

  @override
  String get save => 'Save changes';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get due_at => 'Add completion date';

  @override
  String get due_at_help_text => 'Select the task completion date';

  @override
  String get change_color => 'Select color';

  @override
  String get mandatory_title => 'Title is mandatory';

  @override
  String get mandatory_color => 'Color is mandatory';

  @override
  String get task_saved => 'Task saved successfully!';

  @override
  String get task_saved_error => 'Error saving task!';

  @override
  String get sort => 'Sort';

  @override
  String get alphabetical_order => 'Alphabetical order';

  @override
  String get created_date => 'Created date';

  @override
  String get completion_date => 'Completed date';
}
