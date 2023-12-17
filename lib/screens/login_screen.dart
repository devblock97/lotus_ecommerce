import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              TextFormWidget(label: 'Email'),
              const Gap(20),
              TextFormWidget(
                label: 'Password',
                controller: null,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GroceryApp()));
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
    );
  }
}
