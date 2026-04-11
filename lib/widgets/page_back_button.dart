import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class PageBackButton extends StatelessWidget {
  const PageBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FButton(
      variant: .ghost,
      mainAxisSize: MainAxisSize.min,
      prefix: const Icon(FIcons.chevronLeft),
      onPress: () => Navigator.of(context).pop(),
      child: const Text('Quay lại'),
    );
  }
}