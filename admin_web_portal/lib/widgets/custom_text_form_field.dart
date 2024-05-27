import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String typefield;
  final TextEditingController controller;
  // final String? Function(String? value)? valider;
  bool issecurse;
  final IconData icon;
  // final bool enable;
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    // this.valider,
    required this.issecurse,
    required this.icon,
    // required this.enable,
    required this.typefield,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  IconData iconsuffix = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.issecurse,
      onChanged: (value) {
        print(value);
      },
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurpleAccent,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
            width: 2,
          ),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.typefield == "password"
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.issecurse = !widget.issecurse;
                    iconsuffix = iconsuffix == Icons.visibility
                        ? Icons.visibility_off
                        : Icons.visibility;
                  });
                },
                icon: Icon(iconsuffix, color: Colors.deepPurpleAccent))
            : const SizedBox(
                width: 5,
                height: 10,
              ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        icon: Icon(
          widget.icon,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
