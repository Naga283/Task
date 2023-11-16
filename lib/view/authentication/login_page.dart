import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/textformfield_error_text_state_provider.dart';
import 'package:task/view/authentication/icon_with_heading_subheading.dart';
import 'package:task/view/authentication/login_textform_field.dart';
import 'package:task/view/authentication/password_text_form_field.dart';
import 'package:task/view/authentication/register_page.dart';
import 'package:task/providers/is_loading_state_provider.dart';
import 'package:task/services/firebase_authentication.dart';
import 'package:task/utils/colors.dart';
import 'package:task/view/components/expanded_elevated_btn.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.whiteColor.withOpacity(0.4),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const IconWithHeadingAndSubHeading(
              heading: 'Login',
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  LoginTextFormField(
                    hintText: 'Your e-mail',
                    textEditingController: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextFormField(
                    isPasswordVisible: isPasswordVisible,
                    passwordController: passwordController,
                    errorText: ref.watch(errorTextFormProvider),
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (builder) {
                          return const RegisterPage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an Account?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16,
          right: 16,
        ),
        child: ExpandedElevatedBtn(
          btnName: "Login",
          isLoading: ref.watch(isLoadingStateProvider),
          onTap: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await loginWithEmailAndPassword(
                emailController.text,
                passwordController.text,
                context,
                ref,
              );
            }
          },
        ),
      ),
    );
  }
}
