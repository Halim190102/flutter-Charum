import 'package:charum/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
  });

  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(
          context,
        ),
        borderRadius: BorderRadius.circular(5));
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        fillColor: white,
        hintText: widget.hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass ? _passwordVisible : false,
    );
  }
}
