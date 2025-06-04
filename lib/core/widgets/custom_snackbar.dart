import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

class CustomSnackBar {
  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    IconData? icon,
  }) {
    Color bgColor;
    IconData displayIcon;

    switch (type) {
      case SnackBarType.success:
        bgColor = Colors.green;
        displayIcon = Icons.check_circle;
        break;
      case SnackBarType.error:
        bgColor = Colors.redAccent;
        displayIcon = Icons.error;
        break;
      case SnackBarType.info:
      default:
        bgColor = Colors.blueAccent;
        displayIcon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(icon ?? displayIcon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
