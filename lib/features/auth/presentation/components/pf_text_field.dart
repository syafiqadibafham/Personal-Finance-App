import 'package:flutter/material.dart';

class PfTextField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final Function(String value)? onChanged;
  final bool obscureText;

  const PfTextField({super.key, this.labelText, this.errorText, this.onChanged, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(12),
          )),
      onChanged: onChanged,
    );
  }
}
