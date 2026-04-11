import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/pages/settings_page.dart';
import 'package:gdvn/widgets/settings_group_card.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  void _openSettings(BuildContext context) {
    Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SettingsGroupCard(
                children: [
                  SettingsRowTile(
                    title: 'Cài đặt',
                    subtitle: 'Giao diện và các tuỳ chọn ứng dụng',
                    leading: const SettingsLeadingIcon(
                      icon: CupertinoIcons.gear_alt_fill,
                      backgroundColor: Color(0xFF8E8E93),
                    ),
                    showChevron: true,
                    onTap: () => _openSettings(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
