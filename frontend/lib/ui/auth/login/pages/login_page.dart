import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/routing/routes.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
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
                          readOnly: _viewModel.login.running,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira seu e-mail';
                            }
                            if (!value.contains('@')) {
                              return 'Insira um e-mail valido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          readOnly: _viewModel.login.running,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira uma senha';
                            }
                            if (value.length < 6 || value.contains(' ')) {
                              return 'Insira uma senha valida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 20),
                        if (_viewModel.login.running)
                          const CircularProgressIndicator()
                        else
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _viewModel.login.execute(
                                  (
                                    _emailController.text,
                                    _passwordController.text
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _viewModel.login.running
                              ? null
                              : () {
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
    );
  }

  Future<void> _result() async {
    if (_viewModel.login.error) {
      _viewModel.login.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
