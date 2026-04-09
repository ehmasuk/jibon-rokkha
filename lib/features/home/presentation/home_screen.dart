import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/search_bar.dart';
import 'widgets/quick_actions.dart';
import 'widgets/category_grid.dart';
import 'widgets/call_strip.dart';
import 'widgets/see_all_button.dart';
import '../../aid/presentation/all_aids_screen.dart';
import '../../emergency/presentation/emergency_call_screen.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/sonrokkhito_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  Widget _buildHomeTab() {
    return Column(
      children: [
        _buildCustomHeader(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const QuickActions(),
                const SizedBox(height: 12),
                EmergencyCallStrip(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
                const SizedBox(height: 12),
                const CategoryGrid(),
                SeeAllButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 0,
        right: 0,
        bottom: 0,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.primaryRed,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'প্রাথমিক চিকিৎসা',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      'জরুরি সাহায্য',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BengaliSearchBar(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(),
      const AllAidsScreen(),
      const SonrokkhitoTab(),
      const EmergencyCallScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryRed,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'হোম'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'সব বিষয়'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'সংরক্ষিত'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'জরুরি কল'),
        ],
      ),
    );
  }
}
