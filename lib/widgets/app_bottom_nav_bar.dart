import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class NavItemConfig {
  final IconData icon;
  final String label;
  final Widget page;

  const NavItemConfig({
    required this.icon,
    required this.label,
    required this.page,
  });
}

const int actionButtonIndex = 2;

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onActionPressed;
  final List<NavItemConfig> leftItems;
  final List<NavItemConfig> rightItems;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onActionPressed,
    required this.leftItems,
    required this.rightItems,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final actionBgColor =
        isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final actionFgColor =
        isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);

    return FBottomNavigationBar(
      index: selectedIndex,
      onChange: (index) {
        if (index == actionButtonIndex) {
          onActionPressed();
        } else {
          onItemSelected(index);
        }
      },
      children: [
        ...leftItems.map(
          (item) => FBottomNavigationBarItem(
            icon: Icon(item.icon),
            label: Text(item.label),
          ),
        ),
        FBottomNavigationBarItem(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: actionBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  color: actionFgColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  height: 1.0,
                ),
              ),
            ),
          ),
          label: const Text(''),
        ),
        ...rightItems.map(
          (item) => FBottomNavigationBarItem(
            icon: Icon(item.icon),
            label: Text(item.label),
          ),
        ),
      ],
    );
  }

  static Widget getPage({
    required int selectedIndex,
    required List<NavItemConfig> leftItems,
    required List<NavItemConfig> rightItems,
  }) {
    if (selectedIndex < actionButtonIndex) {
      return leftItems[selectedIndex].page;
    }
    final rightIndex = selectedIndex - actionButtonIndex - 1;
    return rightItems[rightIndex].page;
  }
}
