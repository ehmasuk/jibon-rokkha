import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jibon_rokkha/core/providers/bookmark_provider.dart';
import 'package:jibon_rokkha/features/home/providers/home_provider.dart';
import 'package:jibon_rokkha/features/aid/presentation/aid_detail_screen.dart';
import 'package:jibon_rokkha/core/theme/app_theme.dart';

class SonrokkhitoTab extends ConsumerWidget {
  const SonrokkhitoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarkProvider);
    final allAidsAsync = ref.watch(allAidsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('সংরক্ষিত বিষয় (Saved)', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppTheme.primaryRed,
        elevation: 0,
      ),
      body: allAidsAsync.when(
        data: (allAids) {
          final bookmarkedAids = allAids.where((aid) => bookmarkedIds.contains(aid.id)).toList();

          if (bookmarkedAids.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'কোনো বিষয় সংরক্ষিত নেই',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'আপনার গুরুত্বপূর্ণ বিষয়গুলো এখানে সংরক্ষণ করে রাখতে পারেন।',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bookmarkedAids.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final aid = bookmarkedAids[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryRed.withValues(alpha: 0.1),
                    child: const Icon(Icons.bookmark, color: AppTheme.primaryRed),
                  ),
                  title: Text(
                    aid.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    aid.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AidDetailScreen(aid: aid),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
