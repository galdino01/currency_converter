import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.prefix,
  }) : super(key: key);

  final String label;
  final String prefix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        border: const OutlineInputBorder(),
        prefixText: widget.prefix,
      ),
    );
  }
}