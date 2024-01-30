import 'dart:convert';

import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signup_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../inject_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final username = TextEditingController();
  final password = TextEditingController();
  final authBloc = sl<AuthBloc>();

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthenticationSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const GroceryApp()),
                  (route) => false,
            ).then((value) => Navigator.pop(context));
          }
          if (state is AuthenticationLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 6),
                );
              },
            );
          }
          if (state is AuthenticationInvalid) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.error),
              onAnimationControllerInit: (controller) {
                animationController = controller;
              }
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Gap(50),
                SvgPicture.asset('assets/icons/logo.svg'),
                const Gap(50),
                RichText(
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    text: const TextSpan(
                        text: 'Login\n',
                        style: TextStyle(
                            color: primaryText,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Enter your emails and password',
                              style:
                                  TextStyle(color: secondaryText, fontSize: 16))
                        ])),
                const Gap(30),
                TextFormWidget(label: 'Email', controller: username,),
                const Gap(20),
                TextFormWidget(
                  label: 'Password',
                  controller: password,
                  obscureText: true,
                ),
                const Gap(10),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Forget Password?',
                    textAlign: TextAlign.end,
                  ),
                ),
                const Gap(30),
                ElevatedButton(
                  onPressed: () async {
                    final authentication = AuthModel(username.text, password.text);
                    authBloc.add(SignInRequest(authentication));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(22),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: primaryButton),
                  child: const Text('Login'),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    print('On tap to signup');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SingUpScreen()));
                  },
                  child: RichText(
                    text: const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: secondaryText),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Singup',
                              style: TextStyle(color: primaryButton))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
