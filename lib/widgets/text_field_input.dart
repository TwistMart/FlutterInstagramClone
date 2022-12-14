import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {

  final TextEditingController textEditingController; // custom variable[TextEditingController] for our fields(email, username, password)
  final bool isPass; // look if is password or not [True/False]
  final String hintText; // hint which is in string format
  final TextInputType
      textInputType; // custom variable[TextInputType] for our field type i.e if is email, username, password

  const TextFieldInput(
      { // accept the above values in a constructor
      required this.textEditingController,
      this.isPass = false, // usually isPass is set to false as default
      required this.hintText,
      required this.textInputType,
      super.key});

  @override
  Widget build(BuildContext context) {
    final InputBorder = // final InputBorder has been used to help to avoid redudancy of 'OutlineInputBorder(borderSide: Divider.createBorderSide(context))'
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField( //widget for input fields
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder,
          focusedBorder: InputBorder,
          enabledBorder: InputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText:
          isPass, // this is the password format of making it to right ... instead of text format[This argument gives us the power to hide the data entered in the input field. ]
    );
  }
}
