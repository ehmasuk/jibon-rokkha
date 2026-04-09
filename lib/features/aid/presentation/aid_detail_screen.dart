import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jibon_rokkha/models/aid_model.dart';
import 'package:jibon_rokkha/core/theme/app_theme.dart';
import 'package:jibon_rokkha/core/services/pdf_service.dart';
import 'package:jibon_rokkha/core/providers/bookmark_provider.dart';

class AidDetailScreen extends ConsumerStatefulWidget {
  final AidModel aid;
  const AidDetailScreen({super.key, required this.aid});

  @override
  ConsumerState<AidDetailScreen> createState() => _AidDetailScreenState();
}

class _AidDetailScreenState extends ConsumerState<AidDetailScreen> {
  bool _isDownloading = false;
  final GlobalKey _boundaryKey = GlobalKey();

  Future<void> _downloadPdf() async {
    setState(() => _isDownloading = true);

    try {
      // Small delay to ensure UI is fully rendered
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Get the RepaintBoundary's rendering object
      final boundary = _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      
      if (boundary != null) {
        // Capture as high-resolution image
        final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        
        if (byteData != null) {
          final imageBytes = byteData.buffer.asUint8List();
          final success = await FirstAidPdfService.generateAndSavePdfFromImage(
            imageBytes, 
            widget.aid.title
          );

          if (mounted) {
            setState(() => _isDownloading = false);
            _showStatusSnackBar(success);
          }
        } else {
          throw Exception('Could not convert image to data');
        }
      } else {
        throw Exception('RepaintBoundary not found');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDownloading = false);
        _showStatusSnackBar(false);
      }
    }
  }

  void _showStatusSnackBar(bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'PDF ডাউনলোড সফল হয়েছে' : 'PDF ডাউনলোড ব্যর্থ হয়েছে',
          style: const TextStyle(fontFamily: 'HindSiliguri'),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppTheme.primaryRed,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(
                  ref.watch(bookmarkProvider).contains(widget.aid.id)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
                onPressed: () => ref.read(bookmarkProvider.notifier).toggleBookmark(widget.aid.id),
                tooltip: 'সংরক্ষণ করুন',
              ),
              _isDownloading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.picture_as_pdf),
                      onPressed: _downloadPdf,
                      tooltip: 'PDF ডাউনলোড করুন',
                    ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.aid.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB71C1C), AppTheme.primaryRed],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              key: _boundaryKey,
              child: Container(
                color: Colors.white, // Background for high-quality capture
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Overview
                  _SectionCard(
                    icon: Icons.info_outline,
                    title: 'সংক্ষিপ্ত বিবরণ',
                    iconColor: Colors.blue,
                    child: Text(widget.aid.overview,
                        style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
                  ),
                  const SizedBox(height: 12),

                  // Symptoms
                  if (widget.aid.symptoms.isNotEmpty)
                    _SectionCard(
                      icon: Icons.warning_amber_rounded,
                      title: 'লক্ষণসমূহ',
                      iconColor: Colors.orange,
                      child: Column(
                        children: widget.aid.symptoms
                            .map((s) => _BulletRow(text: s, color: Colors.orange))
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Steps
                  if (widget.aid.steps.isNotEmpty)
                    _SectionCard(
                      icon: Icons.list_alt,
                      title: 'করণীয় ধাপসমূহ',
                      iconColor: AppTheme.primaryRed,
                      child: Column(
                        children: widget.aid.steps.asMap().entries.map((e) {
                          final step = e.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: AppTheme.primaryRed,
                                  child: Text('${step.step}',
                                      style: const TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(step.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 14)),
                                      Text(step.description,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade700,
                                              height: 1.4)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Dos and Don'ts
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.aid.dos.isNotEmpty)
                        Expanded(
                          child: _SectionCard(
                            icon: Icons.check_circle_outline,
                            title: 'করণীয়',
                            iconColor: Colors.green,
                            child: Column(
                              children: widget.aid.dos
                                  .map((d) => _BulletRow(text: d, color: Colors.green))
                                  .toList(),
                            ),
                          ),
                        ),
                      if (widget.aid.dos.isNotEmpty && widget.aid.donts.isNotEmpty) const SizedBox(width: 10),
                      if (widget.aid.donts.isNotEmpty)
                        Expanded(
                          child: _SectionCard(
                            icon: Icons.cancel_outlined,
                            title: 'বর্জনীয়',
                            iconColor: Colors.red,
                            child: Column(
                              children: widget.aid.donts
                                  .map((d) => _BulletRow(text: d, color: Colors.red))
                                  .toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // When to seek help
                  if (widget.aid.whenToSeekHelp.isNotEmpty)
                    _SectionCard(
                      icon: Icons.local_hospital_outlined,
                      title: 'কখন ডাক্তার ডাকবেন',
                      iconColor: Colors.purple,
                      child: Column(
                        children: widget.aid.whenToSeekHelp
                            .map((w) => _BulletRow(text: w, color: Colors.purple))
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 6),
                Text(title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;
  final Color color;
  const _BulletRow({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 7, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
          ),
        ],
      ),
    );
  }
}
