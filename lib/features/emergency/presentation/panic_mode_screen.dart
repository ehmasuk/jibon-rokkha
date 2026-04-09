import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PanicModeScreen extends StatelessWidget {
  const PanicModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 8 Major emergency types for panic mode
    final List<Map<String, dynamic>> sosItems = [
      {'name': 'হার্ট অ্যাটাক', 'icon': Icons.favorite},
      {'name': 'শ্বাসরোধ', 'icon': Icons.air},
      {'name': 'তীব্র রক্তপাত', 'icon': Icons.bloodtype},
      {'name': 'অজ্ঞান হওয়া', 'icon': Icons.person_off},
      {'name': 'ডুবে যাওয়া', 'icon': Icons.water_drop},
      {'name': 'বিদ্যুৎস্পৃষ্ট', 'icon': Icons.electric_bolt},
      {'name': 'বিষক্রিয়া', 'icon': Icons.science},
      {'name': 'সড়ক দুর্ঘটনা', 'icon': Icons.car_crash},
    ];

    return Scaffold(
      backgroundColor: AppTheme.primaryRed,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryRed,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'আপনার কি হয়েছে?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: sosItems.length,
              itemBuilder: (context, index) {
                final item = sosItems[index];
                return ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to specific Aid Detail
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'], size: 40),
                      const SizedBox(height: 12),
                      Text(
                        item['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Sticky SOS 999 Button
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black.withValues(alpha: 0.2),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton.icon(
                  onPressed: () => _makePhoneCall('999'),
                  icon: const Icon(Icons.call, size: 30),
                  label: const Text(
                    '৯৯৯ কল করুন',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
}
