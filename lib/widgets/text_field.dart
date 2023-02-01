import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  const MyTextField({super.key, required this.controller, this.maxLines = 1, this.keyboardType});

  @override
  Widget build(BuildContext context) {

    InputBorder borderDecoration = const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.white,width: 0.75)
        );

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: 'Note title',
        labelText: 'Note title',
        border: borderDecoration,
      ),
      keyboardType: keyboardType,
    );
  }
}