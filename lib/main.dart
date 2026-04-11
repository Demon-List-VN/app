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
    return FTheme(
      data: FThemes.neutral.light.touch,
      child: const AppShell(),
    );
  }
}
