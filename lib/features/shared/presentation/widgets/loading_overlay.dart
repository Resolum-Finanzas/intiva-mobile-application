import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// A widget that overlays a semi-transparent loading indicator on top of
/// its [child] when [isLoading] is true.
///
/// Used across all features to provide consistent loading feedback during
/// async operations such as API calls, form submissions, and data fetches.
/// The overlay renders a black background at 30 % opacity with a centered
/// [CircularProgressIndicator] tinted in [AppColors.primary], ensuring the
/// indicator is always visible regardless of the underlying content color.
///
/// Example:
/// ```dart
/// LoadingOverlay(
///   isLoading: state.status == Status.loading,
///   child: MyFormWidget(),
/// )
/// ```
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
