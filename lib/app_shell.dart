import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/pages/dashboard_page.dart';
import 'package:gdvn/pages/list_page.dart';
import 'package:gdvn/pages/me_page.dart';
import 'package:gdvn/pages/notification_page.dart';
import 'package:gdvn/widgets/action_bottom_sheet.dart';
import 'package:gdvn/widgets/app_bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _leftItems = [
    NavItemConfig(
      icon: FIcons.layoutDashboard,
      label: 'Dashboard',
      page: DashboardPage(),
    ),
    NavItemConfig(
      icon: FIcons.list,
      label: 'List',
      page: ListPage(),
    ),
  ];

  static const _rightItems = [
    NavItemConfig(
      icon: FIcons.bell,
      label: 'Notification',
      page: NotificationPage(),
    ),
    NavItemConfig(
      icon: FIcons.user,
      label: 'Me',
      page: MePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      footer: AppBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() => _selectedIndex = index),
        onActionPressed: () => showActionBottomSheet(context),
        leftItems: _leftItems,
        rightItems: _rightItems,
      ),
      child: AppBottomNavBar.getPage(
        selectedIndex: _selectedIndex,
        leftItems: _leftItems,
        rightItems: _rightItems,
      ),
    );
  }
}
