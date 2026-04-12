import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/theme/app_theme.dart';
import 'package:gdvn/widgets/page_back_button.dart';
import 'package:gdvn/widgets/settings_group_card.dart';

const double _horizontalPadding = 10;

String _themeModeLabel(AppThemeMode themeMode) {
  return switch (themeMode) {
    AppThemeMode.system => 'Theo hệ thống',
    AppThemeMode.dark => 'Tối',
    AppThemeMode.light => 'Sáng',
  };
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = AppThemeScope.of(context);

    return FScaffold(
      header: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: PageBackButton(),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                  ),
                  child: Text(
                    'Cài đặt',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                  ),
                  child: ValueListenableBuilder<AppThemeMode>(
                    valueListenable: themeController,
                    builder: (context, themeMode, _) {
                      return FTileGroup(
                        children: [
                          FSelectMenuTile<AppThemeMode>(
                            selectControl: FMultiValueControl.managedRadio(
                              initial: themeMode,
                              onChange: (selection) {
                                if (selection.isEmpty) {
                                  return;
                                }

                                themeController.value = selection.first;
                              },
                            ),
                            title: const Text('Giao diện'),
                            subtitle: const Text(
                              'Chọn chế độ sáng tối cho ứng dụng.',
                            ),
                            detailsBuilder: (_, values, _) {
                              final selectedThemeMode = values.isEmpty
                                  ? themeMode
                                  : values.first;

                              return Text(_themeModeLabel(selectedThemeMode));
                            },
                            menu: const [
                              FSelectTile<AppThemeMode>.suffix(
                                value: AppThemeMode.system,
                                prefix: SettingsLeadingIcon(
                                  icon: CupertinoIcons.device_phone_portrait,
                                  backgroundColor: Color(0xFF34C759),
                                ),
                                title: Text('Theo hệ thống'),
                                subtitle: Text(
                                  'Tự động theo giao diện của thiết bị',
                                ),
                              ),
                              FSelectTile<AppThemeMode>.suffix(
                                value: AppThemeMode.dark,
                                prefix: SettingsLeadingIcon(
                                  icon: CupertinoIcons.moon_fill,
                                  backgroundColor: Color(0xFF5856D6),
                                ),
                                title: Text('Tối'),
                                subtitle: Text(
                                  'Luôn dùng giao diện tối trong ứng dụng',
                                ),
                              ),
                              FSelectTile<AppThemeMode>.suffix(
                                value: AppThemeMode.light,
                                prefix: SettingsLeadingIcon(
                                  icon: CupertinoIcons.sun_max_fill,
                                  backgroundColor: Color(0xFFFF9F0A),
                                ),
                                title: Text('Sáng'),
                                subtitle: Text(
                                  'Luôn dùng giao diện sáng trong ứng dụng',
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
        ),
      ),
    );
  }
}

