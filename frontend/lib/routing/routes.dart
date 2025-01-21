abstract class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/';
  static const String splash = '/splash';
  static const String task = '/task';
  static String taskWithId(String id) => '$task/$id';
}
