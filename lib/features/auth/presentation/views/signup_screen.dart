import 'package:ecommerce_app/core/extensions/validator.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/presentation.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../inject_container.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isValidate = false;

  final authBloc = sl<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (_ ,state) {
            if (state is AuthenticationLoading) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return const Center(child: CircularProgressIndicator(),);
                  });
            }
            if (state is SignUpSuccess) {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                  builder: (_) => const LoginScreen()), (route) => false);
            }
            if (state is AuthenticationError) {
              Navigator.of(context).pop();
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(message: state.error)
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/sen_hong.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  RichText(
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      text: const TextSpan(
                          text: 'Sign Up\n',
                          style: TextStyle(
                              color: primaryText,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Enter your credentials to continue',
                                style: TextStyle(
                                    color: secondaryText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                          ])),
                  const Gap(30),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Username'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onChanged: (value) {
                      setState(() {
                        isValidate = username.text.isNotEmpty
                            && email.text.isNotEmpty
                            && password.text.isNotEmpty;
                      });
                    },
                    controller: username,
                  ),
                  const Gap(20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    validator: (email) => email!.isValidEmail() ? null : 'Email is invalid',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        isValidate = username.text.isNotEmpty
                            && email.text.isNotEmpty
                            && password.text.isNotEmpty;
                      });
                    },
                    controller: email,
                  ),
                  const Gap(20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      suffixIcon: const Icon(Icons.remove_red_eye)
                    ),
                    onChanged: (value) {
                      setState(() {
                        isValidate = username.text.isNotEmpty
                            && email.text.isNotEmpty
                            && password.text.isNotEmpty;
                      });
                    },
                    controller: password,
                    obscureText: true,
                  ),
                  const Gap(20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Confirm password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                    ),
                    validator: (input) => input!.hasMatchPassword(password.text)
                        ? null : 'Password has not matching',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPassword,
                    obscureText: true,
                  ),
                  const Gap(10),
                  RichText(
                    text: const TextSpan(
                        text: 'By continuing you agree to our ',
                        style: TextStyle(color: secondaryText),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms of Service ',
                              style: TextStyle(color: primaryButton)),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(color: secondaryText),
                          ),
                          TextSpan(
                              text: 'Privacy Policy.',
                              style: TextStyle(color: primaryButton))
                        ]),
                  ),
                  const Gap(30),
                  ElevatedButton(
                    onPressed: isValidate
                        ? () {
                            final body = SignUpModel(
                              username: username.text.toString(),
                              email: email.text.toString(),
                              password: password.text.toString());
                            authBloc.add(SignUpRequest(body));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(22),
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: primaryButton),
                    child: const Text('Sign Up'),
                  ),
                  const Gap(30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: RichText(
                      text: const TextSpan(
                          text: 'I have already an account? ',
                          style: TextStyle(color: secondaryText),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(color: primaryButton)),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
