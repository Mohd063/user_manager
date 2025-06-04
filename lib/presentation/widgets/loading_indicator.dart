import 'package:flutter/material.dart';

/// A reusable loading indicator widget displaying
/// a circular progress spinner with an optional message.
///
/// You can customize the loading message, the color of the spinner,
/// and the style of the message text.
class LoadingIndicator extends StatelessWidget {
  /// The message to display below the loading spinner.
  /// Defaults to "Loading...".
  final String message;

  /// The color of the circular progress indicator.
  /// If not provided, uses the theme's primary color.
  final Color? indicatorColor;

  /// Optional custom text style for the message.
  /// Defaults to a medium grey, size 16 font.
  final TextStyle? messageStyle;

  const LoadingIndicator({
    super.key,
    this.message = "Loading...",
    this.indicatorColor,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        // Add padding around the indicator for spacing
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular progress spinner with optional custom color
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                indicatorColor ?? Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            // Loading message text with customizable style
            Text(
              message,
              style: messageStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
