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
          icon: Icon(FIcons.circlePlus, size: 28),
          label: const Text('Action'),
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
