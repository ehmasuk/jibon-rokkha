import 'package:flutter/material.dart';
import '../../../aid/presentation/category_aids_screen.dart';
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
          child: Text(
            'দ্রুত সাহায্য',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionCard(
                context,
                title: 'হার্ট অ্যাটাক',
                icon: '💖',
                borderColor: Colors.pink.shade200,
                bgColor: Colors.pink.shade50,
                categoryName: 'হার্ট ও রক্তসঞ্চালন',
              ),
              const SizedBox(width: 8),
              _buildActionCard(
                context,
                title: 'শ্বাসরোধ',
                icon: '👤', 
                borderColor: Colors.orange.shade200,
                bgColor: Colors.orange.shade50,
                categoryName: 'শ্বাসনালী ও এয়ারওয়ে',
              ),
              const SizedBox(width: 8),
              _buildActionCard(
                context,
                title: 'রক্তপাত',
                icon: '🩸',
                borderColor: Colors.blue.shade200,
                bgColor: Colors.blue.shade50,
                categoryName: 'রক্তপাত ও ক্ষত',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String icon,
    required Color borderColor,
    required Color bgColor,
    required String categoryName,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryAidsScreen(
                categoryName: categoryName,
                categoryIcon: icon,
              ),
            ),
          );
        },
        child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
