// all textfield which is repeated more than once
//pass all parameters along with controller don't pass onChanged here

import 'package:flutter/material.dart';
import 'package:superstore_app/utils/styles/colors.dart';

class CustomTextFields extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? obSecure;
  final Widget? suffixIcon;
  const CustomTextFields({
    Key? key,
    this.labelText,
    this.controller,
    this.obSecure = false,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 100,
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(labelText!),
          suffixIcon: suffixIcon,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPallet.Pink_COLOR),
          ),
        ),
      ),
    );
  }
}
