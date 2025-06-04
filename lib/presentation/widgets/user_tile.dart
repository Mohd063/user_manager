import 'package:flutter/material.dart';
import 'package:manage_me/data/model/user_model.dart';

/// A reusable widget to display user information in a tile/card format.
/// Supports dark and light themes using ThemeData.
class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: colorScheme.surface, // Adaptive background color

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,

        leading: CircleAvatar(
          radius: 26,
          backgroundColor: colorScheme.primary.withOpacity(0.2),
          backgroundImage:
              user.image.isNotEmpty ? NetworkImage(user.image) : null,
          child: user.image.isEmpty
              ? Text(
                  '${user.firstName[0]}${user.lastName.isNotEmpty ? user.lastName[0] : ''}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              : null,
        ),

        title: Text(
          '${user.firstName} '
          '${user.maidenName.isNotEmpty ? user.maidenName + ' ' : ''}'
          '${user.lastName}',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Text(
          user.email,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
