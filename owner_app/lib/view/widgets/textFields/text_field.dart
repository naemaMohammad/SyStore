import 'package:flutter/material.dart';
import 'package:owner_app/core/theme/color.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isEmail;
  final bool isDescription;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isEmail = false,
    this.isDescription = false,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: isDescription ? 4 : 1,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: const ['Tajawal'],
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
      decoration: InputDecoration(
        hintText: hint,
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
        errorStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color:AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
