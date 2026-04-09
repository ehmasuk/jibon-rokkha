import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SeeAllButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SeeAllButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppTheme.primaryRed.withValues(alpha: 0.4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'সব সাহায্য দেখুন ➔',
          style: TextStyle(
            color: AppTheme.primaryRed,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
