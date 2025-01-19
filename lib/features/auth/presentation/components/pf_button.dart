import 'package:flutter/material.dart';

class PfButton extends StatelessWidget {
  const PfButton({
    super.key,
    required this.labelText,
    required this.onTap,
    this.width = double.infinity,
  });

  final String labelText;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(labelText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
