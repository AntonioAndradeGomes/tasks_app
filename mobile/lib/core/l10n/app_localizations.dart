import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @login_.
  ///
  /// In en, this message translates to:
  /// **'Login.'**
  String get login_;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get no_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up.'**
  String get signup;

  /// No description provided for @have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get have_account;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid e-mail'**
  String get email_invalid;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get field_required;

  /// No description provided for @password_min.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get password_min;

  /// No description provided for @unable_to_login.
  ///
  /// In en, this message translates to:
  /// **'Unable to login'**
  String get unable_to_login;

  /// No description provided for @name_min.
  ///
  /// In en, this message translates to:
  /// **'Name too short'**
  String get name_min;

  /// No description provided for @registration_successful.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully!'**
  String get registration_successful;

  /// No description provided for @registration_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registration_failed;

  /// No description provided for @my_tasks.
  ///
  /// In en, this message translates to:
  /// **'My tasks'**
  String get my_tasks;

  /// No description provided for @add_task.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get add_task;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @concluded.
  ///
  /// In en, this message translates to:
  /// **'Concluded'**
  String get concluded;

  /// No description provided for @no_task.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any tasks'**
  String get no_task;

  /// No description provided for @error_tasks_load.
  ///
  /// In en, this message translates to:
  /// **'Error loading tasks'**
  String get error_tasks_load;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @task_deleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted successfully!'**
  String get task_deleted;

  /// No description provided for @task_deleted_error.
  ///
  /// In en, this message translates to:
  /// **'Error deleting task!'**
  String get task_deleted_error;

  /// No description provided for @task_updated.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully!'**
  String get task_updated;

  /// No description provided for @task_updated_error.
  ///
  /// In en, this message translates to:
  /// **'Error updating task!'**
  String get task_updated_error;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get save;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @due_at.
  ///
  /// In en, this message translates to:
  /// **'Add completion date'**
  String get due_at;

  /// No description provided for @due_at_help_text.
  ///
  /// In en, this message translates to:
  /// **'Select the task completion date'**
  String get due_at_help_text;

  /// No description provided for @change_color.
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get change_color;

  /// No description provided for @mandatory_title.
  ///
  /// In en, this message translates to:
  /// **'Title is mandatory'**
  String get mandatory_title;

  /// No description provided for @mandatory_color.
  ///
  /// In en, this message translates to:
  /// **'Color is mandatory'**
  String get mandatory_color;

  /// No description provided for @task_saved.
  ///
  /// In en, this message translates to:
  /// **'Task saved successfully!'**
  String get task_saved;

  /// No description provided for @task_saved_error.
  ///
  /// In en, this message translates to:
  /// **'Error saving task!'**
  String get task_saved_error;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @alphabetical_order.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical order'**
  String get alphabetical_order;

  /// No description provided for @created_date.
  ///
  /// In en, this message translates to:
  /// **'Created date'**
  String get created_date;

  /// No description provided for @completion_date.
  ///
  /// In en, this message translates to:
  /// **'Completed date'**
  String get completion_date;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
