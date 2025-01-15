import 'package:flutter/material.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final bool readOnly;
  final String hintText;
  final FormFieldValidator<String>? validator;

  const PasswordTextFormFieldWidget({
    super.key,
    required this.passwordController,
    required this.readOnly,
    required this.hintText,
    this.validator,
  });

  @override
  State<PasswordTextFormFieldWidget> createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleObscureText,
        ),
      ),
      validator: widget.validator,
    );
  }
}
