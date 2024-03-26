import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
    return const Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Create new account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(
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
          'Sign up',
          style: TextStyle(color: white),
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
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                height: 175,
                alignment: Alignment.center,
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Confirmation",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Are you sure want to register with credentials that you filled in the register column?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
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
                            child: SizedBox(
                              child: Text(
                                "No, I don't",
                                style: TextStyle(
                                  color: greenCharum,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => const Login(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            width: 105,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              color: greenCharum,
                            ),
                            child: Text(
                              'Yes , I am',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text("Have an account? "),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Log in here.",
              style: TextStyle(fontWeight: FontWeight.bold, color: greenCharum),
            ),
          ),
        )
      ],
    );
  }
}
