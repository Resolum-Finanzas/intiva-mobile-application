import 'package:flutter/material.dart';

enum IntivaButtonVariant { primary, secondary, outlined }

class IntivaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IntivaButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const IntivaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = IntivaButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return switch (variant) {
      IntivaButtonVariant.primary => FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: _child(Colors.white),
      ),
      IntivaButtonVariant.secondary => FilledButton.tonal(
        onPressed: isLoading ? null : onPressed,
        child: _child(theme.colorScheme.primary),
      ),
      IntivaButtonVariant.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: _child(theme.colorScheme.primary),
      ),
    };
  }

  Widget _child(Color color) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: color),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)],
      );
    }
    return Text(label);
  }
}
