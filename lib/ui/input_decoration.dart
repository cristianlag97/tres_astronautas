import 'package:flutter/material.dart';
import 'package:tres_astronautras/ui/colors.dart';

class InputDecorations {

  static InputDecoration matrixInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: orange,
          width: 2
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: orange
        ),
      ),
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: orange,
          width: 3
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: orange
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: orange) : null
    );
  }

}
