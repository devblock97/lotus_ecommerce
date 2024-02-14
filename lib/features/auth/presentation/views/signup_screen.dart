import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/presentation.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../inject_container.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({super.key});

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

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
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
            }
            if (state is AuthenticationError) {
              print('sign up error: ${state.error}');
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Gap(50),
                  SvgPicture.asset('assets/icons/logo.svg'),
                  const Gap(50),
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
                  TextFormWidget(label: 'First name', controller: firstName,),
                  const Gap(20),
                  TextFormWidget(label: 'Last name', controller: lastName,),
                  const Gap(20),
                  TextFormWidget(label: 'Email', controller: email,),
                  const Gap(20),
                  TextFormWidget(
                    label: 'Password',
                    trailingIcon: const Icon(Icons.remove_red_eye),
                    controller: password,
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
                    onPressed: () {
                      final body = SignUpModel(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          email: email.text,
                          password: password.text);
                      if (body != null) {
                        authBloc.add(SignUpRequest(body));
                      }
                    },
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
                          MaterialPageRoute(builder: (context) => SingUpScreen()));
                    },
                    child: RichText(
                      text: const TextSpan(
                          text: 'I have already an account? ',
                          style: TextStyle(color: secondaryText),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign Up',
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
