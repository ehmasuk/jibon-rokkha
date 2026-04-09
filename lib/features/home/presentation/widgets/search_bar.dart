import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class BengaliSearchBar extends StatelessWidget {
  const BengaliSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppTheme.primaryRed.withValues(alpha: 0.7)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'সাহায্য খুঁজুন... (যেমন: পোড়া, সাপ)',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.mic, color: Colors.grey.shade600),
            onPressed: () {
              // TODO: Voice Search
            },
          ),
        ],
      ),
    );
  }
}
