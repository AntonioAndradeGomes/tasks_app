import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/auth/login/widgets/password_text_form_field_widget.dart';
import 'package:frontend/ui/auth/signup/view_model/signup_viewmodel.dart';
import 'package:go_router/go_router.dart';

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
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Cadastre-se.',
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
                    listenable: _viewModel.signup,
                    builder: (context, child) {
                      return Column(
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _nameController,
                            readOnly: _viewModel.signup.running,
                            decoration: const InputDecoration(
                              hintText: 'Nome',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu nome';
                              }
                              if (value.length < 3) {
                                return 'Insira um nome valido';
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
                            readOnly: _viewModel.signup.running,
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
                          PasswordTextFormFieldWidget(
                            passwordController: _passwordController,
                            readOnly: _viewModel.signup.running,
                            hintText: 'Password',
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
                          if (_viewModel.signup.running)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _viewModel.signup.execute(
                                    (
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Cadastrar',
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap:
                                _viewModel.signup.running ? null : context.pop,
                            child: RichText(
                              text: TextSpan(
                                text: 'Já possui uma conta?',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const [
                                  TextSpan(
                                    text: ' Entre',
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
    if (_viewModel.signup.completed) {
      _viewModel.signup.clearResult();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup successful'),
          backgroundColor: Colors.green,
        ),
      );
    }
    if (_viewModel.signup.error) {
      _viewModel.signup.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
