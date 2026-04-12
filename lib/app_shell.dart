import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/pages/dashboard_page.dart';
import 'package:gdvn/pages/list_page.dart';
import 'package:gdvn/pages/me_page.dart';
import 'package:gdvn/pages/notification_page.dart';
import 'package:gdvn/sheets/submit_level_challenge_sheet.dart';
import 'package:gdvn/sheets/submit_record_sheet.dart';
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
      label: 'Trang chủ',
      page: DashboardPage(),
    ),
    NavItemConfig(icon: FIcons.list, label: 'List', page: ListPage()),
  ];

  static const _rightItems = [
    NavItemConfig(
      icon: FIcons.bell,
      label: 'Thông báo',
      page: NotificationPage(),
    ),
    NavItemConfig(icon: FIcons.user, label: 'Tôi', page: MePage()),
  ];

  Future<void> _handleActionPressed() async {
    final action = await showActionBottomSheet(context);
    if (!mounted || action == null) {
      return;
    }

    switch (action) {
      case ActionBottomSheetDestination.submitRecord:
        await showSubmitRecordSheet(context);
      case ActionBottomSheetDestination.submitLevelChallenge:
        await showSubmitLevelChallengeSheet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      footer: AppBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        onActionPressed: _handleActionPressed,
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
