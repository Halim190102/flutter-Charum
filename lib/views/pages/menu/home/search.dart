import 'package:charum/utils/text_field_input.dart';
import 'package:flutter/material.dart';

class Searching extends StatefulWidget {
  const Searching({super.key});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 35,
          child: TextFieldInput(
            function: (data) {},
            radius: true,
            textEditingController: _search,
            isPass: false,
            hintText: 'Search space',
            textInputType: TextInputType.text,
            delete: () {
              _search.clear();
            },
          ),
        ),
      ),
    );
  }
}
