import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/pages/about_page.dart';
import 'package:gdvn/theme/app_theme.dart';
import 'package:gdvn/widgets/floating_page_header.dart';
import 'package:gdvn/widgets/settings_group_card.dart';

const double _horizontalPadding = 10;

String _themeModeLabel(AppThemeMode themeMode) {
  return switch (themeMode) {
    AppThemeMode.system => 'Theo hệ thống',
    AppThemeMode.dark => 'Tối',
    AppThemeMode.light => 'Sáng',
  };
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _openAboutPage() {
    Navigator.of(context).push<void>(
      CupertinoPageRoute<void>(builder: (context) => const AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = AppThemeScope.of(context);

    return FloatingPageHeader(
      title: 'Cài đặt',
      leadingAction: FloatingPageHeaderAction(
        icon: const Icon(CupertinoIcons.back),
        onTap: () => Navigator.maybePop(context),
        semanticsLabel: 'Quay lại',
      ),
      trailingAction: FloatingPageHeaderAction(
        icon: const Icon(CupertinoIcons.info),
        onTap: _openAboutPage,
        semanticsLabel: 'Giới thiệu',
      ),
      child: FScaffold(
        child: FloatingPageHeaderContent(
          child: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              children: [
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
        ),
      ),
    );
  }
}
