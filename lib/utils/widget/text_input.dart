import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class TextInput extends StatefulWidget {

  final TextEditingController textEditingController;
  final String hintText;
  final bool isPasswordField;
  final bool isEnabled;
  final IconData icon;
  final TextInputAction imeAction;
  final bool isNumberOnly;
  final int maxLength;

  const TextInput({
    super.key,
    required this.textEditingController,
    required this.icon,
    required this.hintText,
    this.isPasswordField = false,
    this.isEnabled = true,
    this.imeAction = TextInputAction.done,
    this.isNumberOnly = false,
    this.maxLength = 100
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.isPasswordField?!isPasswordVisible:false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: hintTextColor,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontStyle: FontStyle.normal
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black87)
          ),
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPasswordField?IconButton(
              onPressed: (){
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(isPasswordVisible?Icons.visibility:Icons.visibility_off)
          ): SizedBox()
        ),
        textInputAction: widget.imeAction,
        autofillHints: const [],
        autocorrect: false,
        enabled: widget.isEnabled,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.normal
        ),
        keyboardType: widget.isNumberOnly
            ? TextInputType.number
            : TextInputType.text,
        inputFormatters: widget.isNumberOnly
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        maxLength: widget.maxLength,
      ),
    );
  }
}
