import 'package:flutter/material.dart';
import 'package:igclone/data/notifiers.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          indicatorColor: Colors.grey.withValues(alpha: 0.01),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled, size: 35), label: ''),
            NavigationDestination(icon: Icon(Icons.search_rounded, size: 35), label: ''),
            NavigationDestination(icon: Icon(Icons.add_box_outlined, size: 35), label: ''),
            NavigationDestination(icon: Icon(Icons.play_circle_outlined, size: 35), label: ''),
            NavigationDestination(icon: Icon(Icons.person_pin_rounded, size: 35), label: ''),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
