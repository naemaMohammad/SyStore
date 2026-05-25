import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      obscureText: isPasswordHidden,

      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: const ['Tajawal'],

        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),

      decoration: InputDecoration(
        hintText: widget.hint.tr,

        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,

          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'NunitoSans',
          fontFamilyFallback: const ['Tajawal'],
        ),

        filled: true,

        fillColor: Theme.of(context).secondaryHeaderColor,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),

        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },

          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,

            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
