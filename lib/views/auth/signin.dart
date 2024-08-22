import 'dart:io';

import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/images.dart';
import 'package:charum/utils/loading.dart';
import 'package:charum/utils/snackbar.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/utils/validator.dart';
import 'package:charum/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _cpass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final _key = GlobalKey<FormState>();

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
    final imageFile = ref.watch(imageRegisProvider);
    final size = MediaQuery.of(context).size;

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
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      _text(),
                      const SizedBox(
                        height: 30,
                      ),
                      _picture(context, size, imageFile),
                      const SizedBox(
                        height: 30,
                      ),
                      _form(),
                      const SizedBox(
                        height: 32,
                      ),
                      _regisButton(imageFile),
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
            ),
          ],
        ),
      ),
    );
  }

  _picture(BuildContext context, Size size, String image) {
    return InkWell(
      onTap: () {
        _showSource(context, size);
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: image != '' ? FileImage(File(image)) : null,
            backgroundColor: image != '' ? null : grey,
            child: image != ''
                ? null
                : Icon(
                    Icons.person,
                    color: white,
                    size: 60,
                  ),
          ),
          image != ''
              ? const SizedBox()
              : Positioned(
                  bottom: 2.5,
                  right: 2.5,
                  child: CircleAvatar(
                    backgroundColor: greenCharum,
                    radius: 12,
                    child: Icon(
                      Icons.add,
                      color: white,
                      size: 16,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  _showSource(BuildContext context, Size size) {
    return showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: white,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _source('Galeri', size),
              _source('Kamera', size),
            ],
          ),
        );
      },
    );
  }

  _form() {
    return Column(
      children: [
        TextFieldInput(
          radius: false,
          textEditingController: _username,
          isPass: false,
          valid: (e) => Validator.validateUsername(e),
          hintText: 'Username',
          textInputType: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          radius: false,
          textEditingController: _name,
          isPass: false,
          valid: (e) => Validator.validateNama(e),
          hintText: 'Name',
          textInputType: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          radius: false,
          textEditingController: _email,
          isPass: false,
          valid: (e) => Validator.validateEmail(e),
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
          valid: (e) => Validator.validatePass(e),
          hintText: 'Password',
          textInputType: TextInputType.text,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          radius: false,
          textEditingController: _cpass,
          isPass: true,
          valid: (e) => Validator.validatePassReplay(e, _pass.text),
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

  _regisButton(String image) {
    return InkWell(
      onTap: () async {
        if (_key.currentState!.validate()) {
          if (image != '') {
            modal(context);
            await ref.read(authProvider.notifier).authRegister(
                  context: context,
                  cropped: File(image),
                  name: _name.text,
                  username: _username.text,
                  email: _email.text,
                  password: _pass.text,
                  passwordconfirmation: _cpass.text,
                  ref: ref,
                );
          } else {
            showSnackBarFun(
              context,
              const Text(
                'Image cannot be empty',
              ),
            );
          }
        }
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

  _source(String source, Size size) {
    return InkWell(
      onTap: () async {
        if (source == 'Galeri') {
          final pickedImage = await cropImage(ImageSource.gallery);
          ref.read(imageRegisProvider.notifier).state = pickedImage;
        } else {
          final pickedImage = await cropImage(ImageSource.camera);
          ref.read(imageRegisProvider.notifier).state = pickedImage;
        }
        setState(() {});
        if (!mounted) return;
        Navigator.pop(context);
      },
      child: containerUtils(
        width: size.width * .45,
        height: size.height * .05,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        color: greenCharum,
        child: textUtils(
          text: source,
          color: white,
        ),
      ),
    );
  }

  dialogText() {
    return Column(
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
      ],
    );
  }

  // _modal(String image) {
  //   return showDialog(
  //     context: context,
  //     builder: (ctx) => Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //       clipBehavior: Clip.antiAlias,
  //       child: containerUtils(
  //         padding: const EdgeInsets.all(
  //           20,
  //         ),
  //         height: 175,
  //         alignment: Alignment.center,
  //         color: white,
  //         child: Column(
  //           children: [
  //             dialogText(),
  //             Flexible(
  //               flex: 2,
  //               child: Container(),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 noButton(),
  //                 yesButton(image),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  yesButton(String image) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();
        modal(context);

        ref.invalidate(imageRegisProvider);
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
    );
  }

  noButton() {
    return SizedBox(
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
    );
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
            ref.invalidate(imageRegisProvider);
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
