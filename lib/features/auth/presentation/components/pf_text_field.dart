import 'package:flutter/material.dart';

class PfTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final Function(String value)? onChanged;
  final bool isObscureText;

  const PfTextField({super.key, this.labelText, this.errorText, this.onChanged, this.isObscureText = false, this.controller});

  @override
  State<PfTextField> createState() => _PfTextFieldState();
}

class _PfTextFieldState extends State<PfTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget.controller,
      obscureText: widget.isObscureText ? _isObscured : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
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
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: widget.isObscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
