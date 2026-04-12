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

  static const _allItems = [..._leftItems, ..._rightItems];

  final _navigatorKeys = List.generate(
    _allItems.length,
    (_) => GlobalKey<NavigatorState>(),
  );

  late final _observers = List.generate(
    _allItems.length,
    (i) => _TabNavigatorObserver(onChanged: () => _onTabChanged(i)),
  );

  final _canPops = List.filled(_allItems.length, false);

  /// Maps the bottom nav [_selectedIndex] (which includes the action button slot)
  /// to a 0-based tab index into [_allItems].
  int get _tabIndex =>
      _selectedIndex < actionButtonIndex ? _selectedIndex : _selectedIndex - 1;

  bool get _currentCanPop => _canPops[_tabIndex];

  void _onTabChanged(int tabIndex) {
    final canPop = _navigatorKeys[tabIndex].currentState?.canPop() ?? false;
    if (_canPops[tabIndex] != canPop) {
      setState(() => _canPops[tabIndex] = canPop);
    }
  }

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
    return PopScope(
      canPop: !_currentCanPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _navigatorKeys[_tabIndex].currentState?.maybePop();
        }
      },
      child: FScaffold(
        footer: AppBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() => _selectedIndex = index),
          onActionPressed: _handleActionPressed,
          leftItems: _leftItems,
          rightItems: _rightItems,
        ),
        child: IndexedStack(
          index: _tabIndex,
          children: List.generate(
            _allItems.length,
            (i) => Navigator(
              key: _navigatorKeys[i],
              observers: [_observers[i]],
              onGenerateRoute: (_) => PageRouteBuilder<void>(
                pageBuilder: (_, __, ___) => _allItems[i].page,
                transitionDuration: Duration.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabNavigatorObserver extends NavigatorObserver {
  final VoidCallback onChanged;

  _TabNavigatorObserver({required this.onChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      onChanged();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      onChanged();

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      onChanged();

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      onChanged();
}
