import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/theme/app_theme.dart';
import 'package:gdvn/widgets/page_back_button.dart';
import 'package:gdvn/widgets/settings_group_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = AppThemeScope.of(context);

    return FScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: PageBackButton(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Cài đặt',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Tùy chỉnh giao diện ứng dụng.'),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<AppThemeMode>(
                      valueListenable: themeController,
                      builder: (context, themeMode, _) {
                        return SettingsGroupCard(
                          header: 'Giao diện',
                          footer: 'Chọn chế độ sáng tối cho ứng dụng.',
                          children: [
                            SettingsRowTile(
                              title: 'Theo hệ thống',
                              leading: const SettingsLeadingIcon(
                                icon: CupertinoIcons.device_phone_portrait,
                                backgroundColor: Color(0xFF34C759),
                              ),
                              selected: themeMode == AppThemeMode.system,
                              onTap: () => themeController.value = AppThemeMode.system,
                            ),
                            SettingsRowTile(
                              title: 'Tối',
                              leading: const SettingsLeadingIcon(
                                icon: CupertinoIcons.moon_fill,
                                backgroundColor: Color(0xFF5856D6),
                              ),
                              selected: themeMode == AppThemeMode.dark,
                              onTap: () => themeController.value = AppThemeMode.dark,
                            ),
                            SettingsRowTile(
                              title: 'Sáng',
                              leading: const SettingsLeadingIcon(
                                icon: CupertinoIcons.sun_max_fill,
                                backgroundColor: Color(0xFFFF9F0A),
                              ),
                              selected: themeMode == AppThemeMode.light,
                              onTap: () => themeController.value = AppThemeMode.light,
                            ),
                          ],
                        );
                      },
                    ),
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