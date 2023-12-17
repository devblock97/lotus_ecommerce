import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

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
              TextFormWidget(label: 'Username'),
              const Gap(20),
              TextFormWidget(label: 'Email'),
              const Gap(20),
              TextFormWidget(
                label: 'Password',
                trailingIcon: Icon(Icons.remove_red_eye),
                controller: null,
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
                onPressed: () {},
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(22),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: primaryButton),
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
    );
  }
}
