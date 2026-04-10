import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void main() {
  runApp(const ForuiApp());
}

enum ThemePreference { system, light, dark }

class ForuiApp extends StatefulWidget {
  const ForuiApp({super.key});

  @override
  State<ForuiApp> createState() => _ForuiAppState();
}

class _ForuiAppState extends State<ForuiApp> {
  ThemePreference _themePreference = ThemePreference.system;

  FThemeData get _lightTheme => FThemes.neutral.light.touch;

  FThemeData get _darkTheme => FThemes.neutral.dark.touch;

  ThemeMode get _materialThemeMode {
    switch (_themePreference) {
      case ThemePreference.system:
        return ThemeMode.system;
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GDVN',
      theme: _lightTheme.toApproximateMaterialTheme(),
      darkTheme: _darkTheme.toApproximateMaterialTheme(),
      themeMode: _materialThemeMode,
      home: Builder(
        builder: (context) {
          final Brightness brightness = switch (_themePreference) {
            ThemePreference.system => MediaQuery.platformBrightnessOf(context),
            ThemePreference.light => Brightness.light,
            ThemePreference.dark => Brightness.dark,
          };

          final FThemeData currentTheme =
              brightness == Brightness.dark ? _darkTheme : _lightTheme;

          return FTheme(
            data: currentTheme,
            child: HomeScreen(
              themePreference: _themePreference,
              onThemeChanged: (value) {
                setState(() {
                  _themePreference = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.themePreference,
    required this.onThemeChanged,
  });

  final ThemePreference themePreference;
  final ValueChanged<ThemePreference> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final FThemeData theme = FTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GDVN'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ForUI starter',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A minimal boilerplate with a live light and dark theme switch.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SegmentedButton<ThemePreference>(
                          segments: const [
                            ButtonSegment<ThemePreference>(
                              value: ThemePreference.system,
                              icon: Icon(Icons.phone_iphone),
                              label: SizedBox.shrink(),
                            ),
                            ButtonSegment<ThemePreference>(
                              value: ThemePreference.light,
                              icon: Icon(Icons.light_mode),
                              label: SizedBox.shrink(),
                            ),
                            ButtonSegment<ThemePreference>(
                              value: ThemePreference.dark,
                              icon: Icon(Icons.dark_mode),
                              label: SizedBox.shrink(),
                            ),
                          ],
                          selected: <ThemePreference>{themePreference},
                          onSelectionChanged: (selection) {
                            onThemeChanged(selection.first);
                          },
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FButton(
                              onPress: () {},
                              child: const Text('Primary action'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('Secondary action'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
