import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.type,
    required this.controller,
    required this.label,
    required this.prefix,
    required this.onChanged,
  }) : super(key: key);

  final TextInputType type;
  final TextEditingController controller;
  final String label;
  final String prefix;
  final Function onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.type,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        border: const OutlineInputBorder(),
        prefixText: widget.prefix,
      ),
      onChanged: (context) => widget.onChanged,
    );
  }
}
