import 'package:flutter/material.dart';

/// A styled text field that follows the Intiva design system.
///
/// Wraps [TextField] with consistent border, fill, and label styling.
/// Supports obscuring text (for passwords) and an optional [suffixIcon].
class AppTextField extends StatelessWidget {
  /// Label shown above the input.
  final String label;

  /// Controller for reading and writing the field value.
  final TextEditingController controller;

  /// Whether the text should be obscured (e.g. for passwords).
  final bool obscureText;

  /// Optional widget placed at the end of the input (e.g. visibility toggle).
  final Widget? suffixIcon;

  /// Keyboard type hint for the OS.
  final TextInputType keyboardType;

  /// Creates an [AppTextField].
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.colorScheme.outline),
        floatingLabelStyle: TextStyle(color: theme.colorScheme.primary),
        filled: true,
        fillColor: theme.colorScheme.surface,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
