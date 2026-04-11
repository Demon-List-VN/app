import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

Future<void> showActionBottomSheet(BuildContext context) {
  return showFSheet(
    context: context,
    side: FLayout.btt,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FTile(
              title: const Text('Nộp bản ghi'),
              prefix: const Icon(FIcons.fileText),
              onPress: () => Navigator.of(context).pop(),
            ),
            FTile(
              title: const Text('Nộp level challenge'),
              prefix: const Icon(FIcons.trophy),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    },
  );
}
