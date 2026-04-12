import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

const BorderRadius _sheetBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(24),
  topRight: Radius.circular(24),
);

Future<void> showSubmitSheet(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required String placeholderTitle,
  required String placeholderDescription,
  required String dialogTitle,
  required String dialogDescription,
}) async {
  await showFSheet<void>(
    context: context,
    side: FLayout.btt,
    mainAxisMaxRatio: null,
    draggable: false,
    style: const FModalSheetStyleDelta.delta(
      motion: FModalSheetMotionDelta.delta(
        expandDuration: Duration(milliseconds: 260),
        collapseDuration: Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      ),
    ),
    builder: (sheetContext) {
      return _SubmitSheet(
        icon: icon,
        title: title,
        subtitle: subtitle,
        placeholderTitle: placeholderTitle,
        placeholderDescription: placeholderDescription,
        dialogTitle: dialogTitle,
        dialogDescription: dialogDescription,
      );
    },
  );
}

class _SubmitSheet extends StatelessWidget {
  const _SubmitSheet({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.placeholderTitle,
    required this.placeholderDescription,
    required this.dialogTitle,
    required this.dialogDescription,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String placeholderTitle;
  final String placeholderDescription;
  final String dialogTitle;
  final String dialogDescription;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0,
      maxChildSize: 1,
      shouldCloseOnMinExtent: true,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.card,
            border: Border.all(
              color: theme.colors.border,
              width: theme.style.borderWidth,
            ),
            borderRadius: _sheetBorderRadius,
          ),
          child: ClipRRect(
            borderRadius: _sheetBorderRadius,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colors.border,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const SizedBox(width: 52, height: 4),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colors.border,
                              width: theme.style.borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Icon(icon),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: theme.colors.foreground,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  color: theme.colors.mutedForeground,
                                  fontSize: 14,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _SubmitSectionCard(
                      title: placeholderTitle,
                      description: placeholderDescription,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          _PlaceholderField(label: 'Tên'),
                          SizedBox(height: 12),
                          _PlaceholderField(
                            label: 'Link video hoặc chứng cứ',
                          ),
                          SizedBox(height: 12),
                          _PlaceholderField(
                            label: 'Ghi chú thêm',
                            lines: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SubmitSectionCard(
                      title: 'Dialog placeholder',
                      description:
                          'Nút bên dưới mở một Forui dialog để giữ chỗ cho xác nhận, hướng dẫn hoặc trạng thái hoàn tất.',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FButton(
                            onPress: () => _showPlaceholderDialog(
                              context,
                              title: dialogTitle,
                              description: dialogDescription,
                            ),
                            child: const Text('Mở dialog placeholder'),
                          ),
                        ],
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
  }
}

class _SubmitSectionCard extends StatelessWidget {
  const _SubmitSectionCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.border,
          width: theme.style.borderWidth,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colors.foreground,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: theme.colors.mutedForeground,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _PlaceholderField extends StatelessWidget {
  const _PlaceholderField({required this.label, this.lines = 1});

  final String label;
  final int lines;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.border,
          width: theme.style.borderWidth,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.colors.foreground,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Placeholder',
              style: TextStyle(
                color: theme.colors.mutedForeground,
                fontSize: 14,
              ),
            ),
            if (1 < lines) ...[
              const SizedBox(height: 10),
              ...List.generate(
                lines - 1,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '................................................................',
                    style: TextStyle(
                      color: theme.colors.mutedForeground,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> _showPlaceholderDialog(
  BuildContext context, {
  required String title,
  required String description,
}) async {
  await showFDialog<void>(
    context: context,
    builder: (dialogContext, _, animation) {
      return FDialog(
        animation: animation,
        title: Text(title),
        body: Text(description),
        actions: [
          FButton(
            onPress: () => Navigator.of(dialogContext).pop(),
            child: const Text('Đóng'),
          ),
        ],
      );
    },
  );
}
