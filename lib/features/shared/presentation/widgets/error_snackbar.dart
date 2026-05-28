import 'package:flutter/material.dart';

/// Utility class for displaying a floating error [SnackBar].
///
/// Call [ErrorSnackbar.show] from any widget that has a [BuildContext] to
/// surface a brief, dismissible error message at the bottom of the screen.
abstract class ErrorSnackbar {
  /// Shows a floating error snackbar with the given [message].
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
  }
}
