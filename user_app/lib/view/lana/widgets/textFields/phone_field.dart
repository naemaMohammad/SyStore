import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: const ['Tajawal'],
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'NunitoSans',
          fontFamilyFallback: const ['Tajawal'],
        ),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
        contentPadding: const EdgeInsets.only(
          left: 8,
          right: 20,
          top: 20,
          bottom: 20,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  "assets/images/flog.png",
                  width: 25,
                  height: 16,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 9),
              Container(width: 1, height: 18, color: Colors.grey),
            ],
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
