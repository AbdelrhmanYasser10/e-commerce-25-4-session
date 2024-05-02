import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_app_session/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session/screens/login_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/functions/snack_bar/snack_bar.dart';
import '../utils/text_styles/text_styles.dart';
import '../utils/widgets/app_button/app_button.dart';
import '../utils/widgets/my_text_form_field/my_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is RegestrationError){
                  showSnackBar(
                    title: "Registration Error",
                    message: state.message,
                    context: context,
                    contentType: ContentType.failure,
                  );
                }
                else if (state is RegestrationSuccessfully){
                  showSnackBar(
                    title: "Registration Successfully",
                    message: state.responseModel.message!,
                    context: context,
                    contentType: ContentType.success,
                  );
                }
              },
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Sign Up",
                          style: AppTextStyle.font45OrangeTextStyle(),
                        ),
                      ),
                      verticalSpace(),
                      MyTextFormField(
                        controller: _nameController,
                        title: "Username:",
                        validator: (value) {
                          return null;
                        },
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
                        isPassword: true,
                        title: "Password:",
                        validator: (value) {
                          return null;
                        },
                      ),
                      verticalSpace(),
                      MyTextFormField(
                        controller: _phoneNumberController,
                        title: "Phone Number:",
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      state is RegestrationLoading ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ):AppButton(
                        fn: () {
                          if(_formKey.currentState!.validate()){
                            cubit.register(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
                                phoneNumber: _phoneNumberController.text,
                            );
                          }
                        },
                        text: "Register",
                      ),
                      verticalSpace(),
                      Text.rich(
                        TextSpan(
                            text: "Already have an account? ",
                            style: AppTextStyle.font18GeryTextStyle(),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: AppTextStyle.font18OrangeTextStyle(),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginScreen(),
                                        ),
                                      ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SizedBox verticalSpace() =>
      const SizedBox(
        height: 20.0,
      );
}
