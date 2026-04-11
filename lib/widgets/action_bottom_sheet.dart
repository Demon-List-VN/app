import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

enum ActionBottomSheetDestination {
  submitRecord,
  submitLevelChallenge,
}

Future<ActionBottomSheetDestination?> showActionBottomSheet(
  BuildContext context,
) {
  return showFSheet<ActionBottomSheetDestination>(
    context: context,
    side: FLayout.btt,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: FTileGroup(
            intrinsicWidth: true,
            children: [
              FTile(
                prefix: const Icon(FIcons.fileText),
                title: const Text('Nộp bản ghi'),
                onPress: () => Navigator.of(sheetContext).pop(
                  ActionBottomSheetDestination.submitRecord,
                ),
              ),
              FTile(
                prefix: const Icon(FIcons.trophy),
                title: const Text('Nộp level challenge'),
                onPress: () => Navigator.of(sheetContext).pop(
                  ActionBottomSheetDestination.submitLevelChallenge,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
