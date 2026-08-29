import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_app/core/theme/color.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone_required'.tr; 
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'phone_numbers_only'.tr; 
    }
    if (value.length != 10) {
      return 'phone_length'.tr; 
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: _validatePhone,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: const ['Tajawal'],
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),

      decoration: InputDecoration(
        hintText: hintText.tr, 
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
        errorStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}