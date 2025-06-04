import 'package:flutter/material.dart';
import 'package:manage_me/core/constants/colors.dart';
import 'package:manage_me/data/model/todo_model.dart';

/// A reusable widget to display a single todo item.
/// Shows an icon indicating completion status, the todo text,
/// and optionally a done icon if completed.
/// Supports tap and long press gestures.
class TodoTile extends StatelessWidget {
  /// The todo data to display
  final TodoModel todo;

  /// Callback triggered when the tile is tapped
  final VoidCallback? onTap;

  /// Callback triggered on long press
  final VoidCallback? onLongPress;

  const TodoTile({
    super.key,
    required this.todo,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // Detect if dark mode is enabled
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Select colors based on light or dark mode
    final Color cardBgColor = isDarkMode
        ? AppColors.cardBackgroundDark
        : AppColors.cardBackground;

    final Color textPrimaryColor = isDarkMode
        ? AppColors.textPrimaryDark
        : AppColors.textPrimary;

    final Color textSecondaryColor = isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    final Color borderColor = isDarkMode
        ? AppColors.borderDark ?? AppColors.border
        : AppColors.border;

    final Color completedColor = isDarkMode
        ? AppColors.completedDark ?? AppColors.completed
        : AppColors.completed;

    final Color pendingColor = isDarkMode
        ? AppColors.pendingDark ?? AppColors.pending
        : AppColors.pending;

    final Color shadowColor = isDarkMode
        ? AppColors.shadowDark ?? AppColors.shadow
        : AppColors.shadow;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  todo.completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: todo.completed ? completedColor : pendingColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    todo.todo,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: todo.completed ? textSecondaryColor : textPrimaryColor,
                      decoration:
                          todo.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                if (todo.completed)
                  Icon(Icons.done, color: completedColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
