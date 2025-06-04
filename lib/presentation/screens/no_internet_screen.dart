import 'package:flutter/material.dart';
import 'package:manage_me/core/constants/colors.dart';

/// A screen that informs the user there is no internet connection.
///
/// Displays an icon, a message, and a retry button.
/// The [onRetry] callback is called when the retry button is pressed.
class NoInternetScreen extends StatelessWidget {
  /// Callback triggered when the user taps the retry button.
  final VoidCallback onRetry;

  /// Creates a [NoInternetScreen].
  ///
  /// The [onRetry] callback must not be null.
  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // No internet icon at the top
              Icon(
                Icons.cloud_off,
                size: 100,
                color: AppColors.primary,
              ),
              const SizedBox(height: 32),

              // Title text explaining the no internet situation
              Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle text with additional instructions
              Text(
                "Please check your network settings and try again. "
                "Your data will be synced once you are back online.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.subtitle,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Retry button to attempt reconnecting
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Retry Connection",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
