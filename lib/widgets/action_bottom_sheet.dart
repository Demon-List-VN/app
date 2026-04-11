import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

enum ActionBottomSheetDestination {
  submitRecord,
  submitLevelChallenge,
}

Widget _buildCard({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  final theme = context.theme;
  final contentStyle = theme.cardStyle.contentStyle;
  final borderColor = theme.colors.border;

  return GestureDetector(
    onTap: onTap,
    child: FCard.raw(
      style: FCardStyleDelta.delta(
        decoration: DecorationDelta.boxDelta(
          border: Border.all(color: borderColor),
        ),
      ),
      child: Padding(
        padding: contentStyle.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            SizedBox(height: contentStyle.imageSpacing),
            DefaultTextStyle.merge(
              style: contentStyle.titleTextStyle,
              child: Text(title),
            ),
            SizedBox(height: contentStyle.titleSpacing),
            DefaultTextStyle.merge(
              style: contentStyle.subtitleTextStyle,
              child: Text(subtitle, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<ActionBottomSheetDestination?> showActionBottomSheet(
  BuildContext context,
) {
  return showFSheet<ActionBottomSheetDestination>(
    context: context,
    side: FLayout.btt,
    builder: (sheetContext) {
      return Builder(
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: ColoredBox(
              color: context.theme.colors.background,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCard(
                        context: context,
                        icon: FIcons.fileText,
                        title: 'Nộp bản ghi',
                        subtitle: 'Nộp kết quả chơi level Insane Demon trở lên',
                        onTap: () => Navigator.of(sheetContext).pop(
                          ActionBottomSheetDestination.submitRecord,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCard(
                        context: context,
                        icon: FIcons.trophy,
                        title: 'Nộp level challenge',
                        subtitle: 'Đề xuất thêm challenge level mới vào danh sách',
                        onTap: () => Navigator.of(sheetContext).pop(
                          ActionBottomSheetDestination.submitLevelChallenge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
