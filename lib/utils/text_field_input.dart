import 'package:charum/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
    required this.radius,
    this.function,
    this.delete,
    this.valid,
  });

  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool radius;
  final Function(String)? function;
  final Function()? delete;
  final String? Function(String?)? valid;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _passwordVisible = true;
  bool submit = true;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(
        context,
      ),
      borderRadius: BorderRadius.circular(
        widget.radius ? 20 : 5,
      ),
    );
    return TextFormField(
      validator: widget.valid,
      autovalidateMode: widget.valid != null
          ? submit
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled
          : null,
      onChanged: (e) {
        setState(() {
          !submit;
        });
        widget.function;
      },
      enableInteractiveSelection: false,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixIcon: widget.radius ? const Icon(CupertinoIcons.search) : null,
        fillColor: widget.radius ? lightGrey : white,
        hintText: widget.hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: widget.delete != null
            ? GestureDetector(
                onTap: widget.delete,
                child: Icon(
                  Icons.close,
                  color: grey,
                ),
              )
            : widget.isPass
                ? GestureDetector(
                    onLongPress: () {
                      setState(() {
                        _passwordVisible = false;
                      });
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        _passwordVisible = true;
                      });
                    },
                    child: Icon(
                      _passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: grey,
                    ),
                  )
                : null,
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass ? _passwordVisible : false,
    );
  }
}
