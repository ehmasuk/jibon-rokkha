import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/aid_model.dart';
import '../../home/providers/home_provider.dart';
import '../providers/aid_repository_provider.dart';
import '../../../core/theme/app_theme.dart';

class AddAidScreen extends ConsumerStatefulWidget {
  const AddAidScreen({super.key});

  @override
  ConsumerState<AddAidScreen> createState() => _AddAidScreenState();
}

class _AddAidScreenState extends ConsumerState<AddAidScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  
  String? _selectedCategoryId;
  bool _isSaving = false;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('দয়া করে সব ঘর পূরণ করুন')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final repo = ref.read(aidRepositoryProvider);
    final aidId = repo.generateId();

    try {
      final aid = AidModel(
        id: aidId,
        category: _selectedCategoryId!,
        title: _titleController.text,
        subtitle: _summaryController.text,
        overview: _summaryController.text, // Same as subtitle for now
        symptoms: [],
        steps: [],
        dos: [],
        donts: [],
        whenToSeekHelp: [],
      );

      await repo.saveAid(aid);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('সফলভাবে সংরক্ষিত হয়েছে')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ভুল হয়েছে: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন ফার্স্ট এইড যোগ করুন'),
      ),
      body: _isSaving 
        ? const Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'শিরোনাম (উদা: হার্ট অ্যাটাক)', border: OutlineInputBorder()),
                    validator: (v) => v == null || v.isEmpty ? 'প্রয়োজনীয়' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'ক্যাটাগরি', border: OutlineInputBorder()),
                    items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nameBn))).toList(),
                    onChanged: (v) => setState(() => _selectedCategoryId = v),
                    validator: (v) => v == null ? 'প্রয়োজনীয়' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _summaryController,
                    decoration: const InputDecoration(labelText: 'সংক্ষিপ্ত বর্ণনা', border: OutlineInputBorder()),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryRed),
                      child: const Text('সংরক্ষণ করুন', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    super.dispose();
  }
}
