import 'dart:async';

import 'package:ecommerce_app/core/extensions/validator.dart';
import 'package:ecommerce_app/core/widgets/lotus_market_form.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/presentation.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../inject_container.dart';

final isValidateNotifier = ValueNotifier<bool>(false);

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool isValidate = false;

  final authBloc = sl<AuthBloc>();

  StringBuffer error = StringBuffer();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/icons/sen_hong.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const Gap(30),
                LotusMarketForm(
                  label: 'Username',
                  controller: _username,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(microseconds: 500), () {
                      setState(() {
                        isValidate = _areFieldValid();
                      });
                    });
                  },
                ),
                const Gap(20),
                LotusMarketForm(
                  label: 'Email',
                  controller: _email,
                  validator: (email) => email!.isValidEmail() ? null : 'Email không hợp lệ',
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      setState(() {
                        isValidate = _areFieldValid();
                      });
                    });
                  },
                ),
                const Gap(20),
                LotusMarketForm(
                  label: 'Mật khẩu',
                  controller: _password,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      setState(() {
                        isValidate = _areFieldValid();
                      });
                    });
                  },
                  validator: (value) {
                    if (!value!.isValidPassword()) {
                      return 'Password must be at least 8 characters long and contain:\n'
                          '* At least one uppercase letter (A-Z)\n'
                          '* At least one lowercase letter (a-z)\n'
                          '* At least one number (0-9)\n'
                          '* At least one special character (!@#\$&*~)';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const Gap(20),
                LotusMarketForm(
                  label: 'Xác nhận lại mật khẩu',
                  controller: _confirmPassword,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      setState(() {
                        isValidate = _areFieldValid();
                      });
                    });
                  },
                  validator: (value) => value!.hasMatchPassword(_password.text)
                      ? null : 'Mật khẩu không trùng khớp',
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
                            username: _username.text.toString(),
                            email: _email.text.toString(),
                            password: _password.text.toString());
                          authBloc.add(SignUpRequest(body));
                          if (_formKey.currentState!.validate()) {
                            print('value valid: ${_formKey.currentState}');
                            setState(() {
                              error.clear();
                            });
                          } else {
                            final form = _formKey.currentState;
                            setState(() {
                              error.write('value is invalid');
                            });
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(22),
                      side: BorderSide(
                        color: theme.colorScheme.primary
                      ),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: primaryButton),
                  child: Text('Sign Up', style: theme.textTheme.titleSmall,),
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
    );
  }

  bool _areFieldValid() {
    return _username.text.isNotEmpty
        && _email.text.isNotEmpty
        && _confirmPassword.text.isNotEmpty
        && _password.text.isNotEmpty;
  }
}