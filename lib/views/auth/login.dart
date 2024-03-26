import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/views/auth/signin.dart';
import 'package:charum/views/pages/menu.dart';
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
        child: Container(
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
              const Text("Or sign log in with"),
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
      ),
    );
  }

  _socialMedia(String logo) {
    return Container(
      height: 42,
      width: 42,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        color: white,
      ),
      child: Image.asset(
        'assets/social-media-logo/$logo.png',
      ),
    );
  }

  _form() {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _email,
          isPass: false,
          hintText: 'Email',
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
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
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
            color: greenCharum,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _text() {
    return const Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Welcome back!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(
          "You’ve been missed. You can sign in first to see any threads you searching for.",
        ),
      ],
    );
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        _modal();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const Menu(),
            ),
            (route) => false,
          );
        });
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: greenCharum,
        ),
        child: Text(
          'Log in',
          style: TextStyle(color: white),
        ),
      ),
    );
  }

  _forSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text("Don't have an account? "),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const Signin(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Sign up here.",
              style: TextStyle(fontWeight: FontWeight.bold, color: greenCharum),
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
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        title: Image.asset(
          'assets/logo/loading.png',
          width: 120,
        ),
        content: const Text(
          "Please wait...",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
