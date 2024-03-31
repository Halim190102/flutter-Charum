import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: containerUtils(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  _text(),
                  const SizedBox(
                    height: 42,
                  ),
                  _form(),
                  const SizedBox(
                    height: 16,
                  ),
                  _forgotPasswordButton(),
                  const SizedBox(
                    height: 32,
                  ),
                  _loginButton(),
                  const SizedBox(
                    height: 24,
                  ),
                  textUtils(text: "Or sign log in with"),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _socialMedia('google'),
                          _socialMedia('facebook'),
                          _socialMedia('twitter'),
                        ],
                      )),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  _forSignUpButton()
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  _socialMedia(String logo) {
    return containerUtils(
      height: 42,
      width: 42,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      borderColor: grey,
      borderRadius: 10,
      color: white,
      child: Image.asset(
        'assets/social-media-logo/$logo.png',
      ),
    );
  }

  _form() {
    return Column(
      children: [
        TextFieldInput(
          radius: false,
          textEditingController: _email,
          isPass: false,
          hintText: 'Email',
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          radius: false,
          textEditingController: _pass,
          isPass: true,
          hintText: 'Password',
          textInputType: TextInputType.text,
        ),
      ],
    );
  }

  _forgotPasswordButton() {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.centerRight,
        child: textUtils(
          text: 'Forgot Password ?',
          color: greenCharum,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  _text() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: textUtils(
            text: "Welcome back!",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        textUtils(
          text:
              "You’ve been missed. You can sign in first to see any threads you searching for.",
        ),
      ],
    );
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        _modal();
        _homePage();
      },
      child: containerUtils(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        color: greenCharum,
        child: textUtils(
          text: 'Log in',
          color: white,
        ),
      ),
    );
  }

  _forSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: textUtils(text: "Don't have an account? "),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/signin');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: textUtils(
              text: "Sign up here.",
              weight: FontWeight.bold,
              color: greenCharum,
            ),
          ),
        )
      ],
    );
  }

  _modal() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: const EdgeInsets.only(bottom: 20),
        backgroundColor: white,
        surfaceTintColor: transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        title: Image.asset(
          'assets/logo/loading.png',
          width: 120,
        ),
        content: textUtils(
          text: "Please wait...",
          weight: FontWeight.bold,
          size: 18,
          align: TextAlign.center,
        ),
      ),
    );
  }

  _homePage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    });
  }
}
