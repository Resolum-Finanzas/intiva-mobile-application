import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// Utility class for displaying success feedback via a floating [SnackBar].
///
/// Mirrors the structure of [ErrorSnackbar] for consistency across the design
/// system. Uses [AppColors.secondary] (green) as the background color with
/// white text styled in Inter 14 px. The snackbar floats above content with
/// rounded corners and auto-dismisses after 3 seconds.
///
/// This class is not instantiable — all functionality is exposed through the
/// static [show] method.
///
/// Example:
/// ```dart
/// SuccessSnackbar.show(context, 'Operación exitosa');
/// ```
abstract class SuccessSnackbar {
  /// Displays a floating green [SnackBar] with the given [message].
  ///
  /// Any currently visible snackbar is dismissed before the new one appears,
  /// preventing stacking.
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.secondary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }
}
