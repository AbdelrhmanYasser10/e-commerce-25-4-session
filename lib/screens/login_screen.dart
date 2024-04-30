import 'package:e_commerce_app_session/screens/sign_up_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:e_commerce_app_session/utils/widgets/my_text_form_field/my_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/widgets/app_button/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Login",
                    style: AppTextStyle.font45OrangeTextStyle(),
                  ),
                ),
                verticalSpace(),
                MyTextFormField(
                  controller: _emailController,
                  title: "Email:",
                  validator: (value) {
                    RegExp reg = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (!reg.hasMatch(value!)) {
                      return "Invaild Email";
                    }
                    return null;
                  },
                ),
                verticalSpace(),
                MyTextFormField(
                  controller: _passwordController,
                  title: "Password:",
                  isPassword:true,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                AppButton(
                  fn: (){},
                  text: "Login",
                ),
                verticalSpace(),
                Text.rich(
                  TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyle.font18GeryTextStyle(),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: AppTextStyle.font18OrangeTextStyle(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignUpScreen(),
                                  ),
                                ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox verticalSpace() => const SizedBox(
        height: 20.0,
      );
}
