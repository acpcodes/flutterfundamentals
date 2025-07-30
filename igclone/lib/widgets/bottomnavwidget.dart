import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';

class BottomNavWidget extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  const BottomNavWidget({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: Colors.white);
          }
          return const TextStyle(color: Colors.black54);
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          return const IconThemeData(color: Colors.black54);
        }),
      ),
      child: NavigationBar(
        backgroundColor: mobileLightModeBGColor,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: widget.onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, size: 35),
            label: '',
            selectedIcon: Icon(Icons.home, color: Colors.black, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.search, size: 35),
            label: '',
            selectedIcon: Icon(Icons.search, color: Colors.black, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box, size: 35),
            label: '',
            selectedIcon: Icon(Icons.add_box, color: Colors.black, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library, size: 35),
            label: '',
            selectedIcon: Icon(Icons.video_library, color: Colors.black, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.person, size: 35),
            label: '',
            selectedIcon: Icon(Icons.person, color: Colors.black, size: 40),
          ),
        ],
      ),
    );
  }
}
