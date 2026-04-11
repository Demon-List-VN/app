import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/app_shell.dart';

void main() {
  runApp(const GdvnApp());
}

class GdvnApp extends StatelessWidget {
  const GdvnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'GDVN',
      color: const Color(0xFF000000),
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
        );
      },
      home: Builder(
        builder: (context) {
          final brightness =
              MediaQuery.maybePlatformBrightnessOf(context) ?? Brightness.light;

          return FTheme(
            data: brightness == Brightness.dark
                ? FThemes.neutral.dark.touch
                : FThemes.neutral.light.touch,
            child: const AppShell(),
          );
        },
      ),
    );
  }
}
