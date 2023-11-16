import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/view/authentication/login_textform_field.dart';

class PasswordTextFormField extends ConsumerWidget {
  const PasswordTextFormField({
    super.key,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.onTap,
    this.errorText,
  });

  final bool isPasswordVisible;
  final TextEditingController passwordController;
  final Function() onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginTextFormField(
      hintText: 'Password',
      errorText: errorText,
      obscureText: isPasswordVisible,
      textEditingController: passwordController,
      suffixIcon: IconButton(
        onPressed: onTap,
        icon: Icon(
          !isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    );
  }
}
