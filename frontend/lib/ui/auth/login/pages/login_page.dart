import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/domain/dtos/credentials.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
import 'package:frontend/ui/auth/login/widgets/password_text_form_field_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late LoginViewModel _viewModel;
  final _credentials = Credentials();

  @override
  void initState() {
    _viewModel = getIt<LoginViewModel>();
    _viewModel.login.addListener(_result);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newViewModel = getIt<LoginViewModel>();
    if (_viewModel != newViewModel) {
      _viewModel.login.removeListener(_result);
      _viewModel = newViewModel;
      _viewModel.login.addListener(_result);
    }
  }

  @override
  void dispose() {
    _viewModel.login.removeListener(_result);
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.login_,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListenableBuilder(
                        listenable: _viewModel.login,
                        builder: (context, child) {
                          return Column(
                            children: [
                              TextFormField(
                                readOnly: _viewModel.login.isRunning,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.email,
                                ),
                                onChanged: _credentials.setEmail,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_required;
                                  }
                                  if (!RegExp(
                                          r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$')
                                      .hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .email_invalid;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              PasswordTextFormFieldWidget(
                                passwordController: _passwordController,
                                readOnly: _viewModel.login.isRunning,
                                onChanged: _credentials.setPassword,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_required;
                                  }
                                  if (value.length < 6) {
                                    return AppLocalizations.of(context)!
                                        .password_min;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (_viewModel.login.isRunning)
                                const CircularProgressIndicator()
                              else
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _viewModel.login.execute(_credentials);
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: _viewModel.login.isRunning
                                    ? null
                                    : () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _emailController.clear();
                                        _passwordController.clear();
                                        _formKey.currentState!.reset();
                                        context.push(Routes.signup);
                                      },
                                child: RichText(
                                  text: TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .no_account,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .signup,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _result() async {
    if (_viewModel.login.isFailure) {
      _viewModel.login.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.unable_to_login),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
