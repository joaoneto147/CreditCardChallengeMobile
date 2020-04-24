import 'package:flutter/material.dart';

class MyCustomTextFormField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool passwordField;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final Icon icon;

  const MyCustomTextFormField(
      {Key key,
      this.hint,
      this.keyboardType = TextInputType.text,
      this.passwordField = false,
      this.controller,
      this.validator,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(            
      autofocus: false,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: passwordField,
      decoration: InputDecoration(
        prefixIcon: icon,
        contentPadding: EdgeInsets.zero,
        hintText: hint,
      ),
      style: TextStyle(fontSize: 20),
    );
  }
}
