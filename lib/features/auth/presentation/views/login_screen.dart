import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signup_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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

  bool isValidate = false;

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
          if (state is AuthenticationSuccess || state is Authenticated) {
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
          if (state is AuthenticationError) {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/icons/sen_hong.png'),
                const Gap(30),
                TextFormField(
                  controller: username,
                  onChanged: (value) {
                    if (password.text.isNotEmpty && username.text.isNotEmpty) {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                    )
                  ),
                ),
                const Gap(20),
                TextFormField(
                  controller: password,
                  onChanged: (value) {
                    if (password.text.isNotEmpty && username.text.isNotEmpty) {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  obscureText: true,
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () => showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                        message: 'Coming soon',
                        backgroundColor: Colors.orange,
                      )
                    ),
                    child: const Text(
                      'Forget Password?',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                const Gap(20),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1.0)),
                    Gap(10),
                    Text('or'),
                    Gap(10),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1.0)),
                  ],
                ),
                const Gap(20),
                OutlinedButton(
                  onPressed: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                          message: 'Coming soon',
                          backgroundColor: Colors.orange
                      )
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                    ),
                    padding: const EdgeInsets.all(16)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 25,
                        height: 25,
                      ),
                      const Gap(10),
                      const Text(
                        'Login with Google',
                        style: TextStyle(
                          color: primaryText,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(10),
                OutlinedButton(
                    onPressed: () {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.info(
                          message: 'Coming soon',
                          backgroundColor: Colors.orange,
                        )
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      padding: const EdgeInsets.all(16)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/apple.svg',
                          width: 25,
                          height: 25,
                        ),
                        const Gap(10),
                        const Text(
                          'Login with Apple',
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                ),
                const Gap(30),
                ElevatedButton(
                  onPressed: (username.text.trim().isNotEmpty && password.text.isNotEmpty)
                  ? () async {
                    final authentication = AuthModel(username.text, password.text);
                    authBloc.add(SignInRequest(authentication));
                  }
                  : null,
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
