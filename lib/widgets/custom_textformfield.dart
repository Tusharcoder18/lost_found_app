import 'package:flutter/material.dart';

// Custom text form field, should be used across the app to maintain common
// appwide UI
Widget CustomTextFormField(
  BuildContext context, {
  final String title,
  final TextInputType keyboardType,
  final String Function(String) validator,
  final void Function(String) onChanged,
  final int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        style:
            Theme.of(context).textTheme.headline1.copyWith(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    ],
  );
}
