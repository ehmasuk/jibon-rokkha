import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jibon_rokkha/models/aid_model.dart';
import 'package:jibon_rokkha/core/providers/firebase_providers.dart';
import 'package:jibon_rokkha/core/theme/app_theme.dart';
import 'package:jibon_rokkha/features/aid/presentation/aid_detail_screen.dart';
import 'package:jibon_rokkha/core/providers/bookmark_provider.dart';

final categoryAidsProvider = StreamProvider.family<List<AidModel>, String>(
  (ref, categoryName) {
    final firestore = ref.watch(firestoreProvider);
    return firestore
        .collection('aids')
        .where('category', isEqualTo: categoryName)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => AidModel.fromMap(d.data(), d.id)).toList());
  },
);

class CategoryAidsScreen extends ConsumerWidget {
  final String categoryName;
  final String categoryIcon;

  const CategoryAidsScreen({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aidsAsync = ref.watch(categoryAidsProvider(categoryName));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Row(
          children: [
            Text(categoryIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                categoryName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: aidsAsync.when(
        data: (aids) {
          if (aids.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(categoryIcon, style: const TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text(
                    'এই বিভাগে এখনো কোনো তথ্য নেই',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: aids.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final aid = aids[index];
              return _AidCard(aid: aid);
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppTheme.primaryRed)),
        error: (err, _) =>
            Center(child: Text('ত্রুটি: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _AidCard extends ConsumerWidget {
  final AidModel aid;
  const _AidCard({required this.aid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(bookmarkProvider).contains(aid.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AidDetailScreen(aid: aid),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.medical_services_outlined,
                        color: AppTheme.primaryRed, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aid.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          aid.subtitle,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 20,
                      color: isBookmarked ? AppTheme.primaryRed : Colors.grey,
                    ),
                    onPressed: () => ref.read(bookmarkProvider.notifier).toggleBookmark(aid.id),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
              if (aid.symptoms.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${aid.symptoms.length}টি লক্ষণ  •  ${aid.steps.length}টি ধাপ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
