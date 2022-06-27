import 'package:flutter/material.dart';

TextFormField customTextFormField({
  required String labelText,
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: const Icon(Icons.cancel_outlined),
        onPressed: () {
          controller.text = "";
        },
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 1,
          color: Colors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 1,
          color: Colors.black,
        ),
      ),
    ),
  );
}
