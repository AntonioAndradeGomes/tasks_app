import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/domain/dtos/user_registration.dart';
import 'package:frontend/domain/validators/user_registration_validator.dart';
import 'package:frontend/ui/auth/login/widgets/password_text_form_field_widget.dart';
import 'package:frontend/ui/auth/signup/view_model/signup_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _userRegistration = UserRegistration();
  final _userRegistrationValidator = UserRegistrationValidator();

  late SignupViewmodel _viewModel;

  @override
  void initState() {
    _viewModel = getIt<SignupViewmodel>();
    _viewModel.signup.addListener(_result);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SignupPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newViewModel = getIt<SignupViewmodel>();
    if (_viewModel != newViewModel) {
      _viewModel.signup.removeListener(_result);
      _viewModel = newViewModel;
      _viewModel.signup.addListener(_result);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _viewModel.signup.removeListener(_result);
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
              ), // Limita a largura máxima
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.signup,
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
                        listenable: _viewModel.signup,
                        builder: (context, child) {
                          return Column(
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _nameController,
                                onChanged: _userRegistration.setName,
                                readOnly: _viewModel.signup.isRunning,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.name,
                                ),
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .field_required;
                                  }
                                  if (name.length < 3) {
                                    return AppLocalizations.of(context)!
                                        .name_min;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _emailController,
                                readOnly: _viewModel.signup.isRunning,
                                onChanged: _userRegistration.setEmail,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.email,
                                ),
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
                                readOnly: _viewModel.signup.isRunning,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                onChanged: _userRegistration.setPassword,
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
                              if (_viewModel.signup.isRunning)
                                const CircularProgressIndicator()
                              else
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _viewModel.signup
                                          .execute(_userRegistration);
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.register,
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: _viewModel.signup.isRunning
                                    ? null
                                    : context.pop,
                                child: RichText(
                                  text: TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .have_account,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .signin,
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
    if (_viewModel.signup.isSuccess) {
      _viewModel.signup.reset();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.registration_successful),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_viewModel.signup.isFailure) {
      _viewModel.signup.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.registration_failed),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
