import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/domain/dtos/credentials.dart';
import 'package:frontend/domain/validators/credentials_validator.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
import 'package:frontend/ui/auth/login/widgets/password_text_form_field_widget.dart';
import 'package:go_router/go_router.dart';

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

  final _validator = CredentialsValidator();
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
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Entrar.',
                    style: TextStyle(
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
                            decoration: const InputDecoration(
                              hintText: 'E-mail',
                            ),
                            onChanged: _credentials.setEmail,
                            validator:
                                _validator.byField(_credentials, 'email'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          PasswordTextFormFieldWidget(
                            passwordController: _passwordController,
                            readOnly: _viewModel.login.isRunning,
                            onChanged: _credentials.setPassword,
                            hintText: 'Password',
                            validator:
                                _validator.byField(_credentials, 'password'),
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
                              child: const Text(
                                'Entrar',
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
                                text: 'Não possui uma conta?',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const [
                                  TextSpan(
                                    text: ' Cadastre-se.',
                                    style: TextStyle(
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
    );
  }

  Future<void> _result() async {
    if (_viewModel.login.isFailure) {
      _viewModel.login.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
