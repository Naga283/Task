import 'package:flutter/material.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/bottom_navbar_current_index_provider.dart';
import 'package:task/services/get_current_user_name.dart';
import 'package:task/utils/colors.dart';
import 'package:task/view/home_page/dashboard.dart';
import 'package:task/view/profile_page/profile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Widget> widgetsPages = [
    const Dashboard(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserFullName(ref);
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = ref.watch(currentIndexStateProvider);

    return Scaffold(
      body: widgetsPages[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (p0) {
          ref.read(currentIndexStateProvider.notifier).state = p0;
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: appColors.primary,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_2),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
