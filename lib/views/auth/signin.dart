import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _cpass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
    _username.dispose();
    _name.dispose();
    _cpass.dispose();
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
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
                      height: 32,
                    ),
                    _loginButton(),
                    const SizedBox(
                      height: 24,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    _forSignUpButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _form() {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _username,
          isPass: false,
          hintText: 'Username',
          textInputType: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          textEditingController: _name,
          isPass: false,
          hintText: 'Name',
          textInputType: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
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
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          textEditingController: _cpass,
          isPass: true,
          hintText: 'Confirm Password',
          textInputType: TextInputType.text,
        ),
      ],
    );
  }

  _text() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: textUtils(
            text: "Create new account",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        textUtils(
          text:
              "Let's make a new account for you to see or create any threads in charum.",
        ),
      ],
    );
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        _modal();
      },
      child: containerUtils(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        color: greenCharum,
        child: textUtils(
          text: 'Sign up',
          color: white,
        ),
      ),
    );
  }

  _modal() {
    return showDialog(
        context: context,
        builder: (ctx) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: containerUtils(
                padding: const EdgeInsets.all(
                  20,
                ),
                height: 175,
                alignment: Alignment.center,
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textUtils(
                      text: "Confirmation",
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SizedBox(height: 3),
                    textUtils(
                      text:
                          "Are you sure want to register with credentials that you filled in the register column?",
                      align: TextAlign.center,
                      size: 12,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 105,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: textUtils(
                              text: "No, I don't",
                              color: greenCharum,
                              size: 12,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              'login',
                              (route) => false,
                            );
                          },
                          child: containerUtils(
                            width: 105,
                            height: 35,
                            alignment: Alignment.center,
                            borderRadius: 15,
                            color: greenCharum,
                            child: textUtils(
                              text: 'Yes , I am',
                              color: white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  _forSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: textUtils(text: "Have an account? "),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: textUtils(
              text: "Log in here.",
              weight: FontWeight.bold,
              color: greenCharum,
            ),
          ),
        )
      ],
    );
  }
}
