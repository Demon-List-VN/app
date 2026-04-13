import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

const double floatingPageHeaderHeight = 44;
const double floatingPageHeaderHorizontalInset = 12;
const double floatingPageHeaderSpacing = 10;
const double floatingPageHeaderTopGap = 10;
const double floatingPageHeaderBottomSpacing = 18;
const double floatingPageHeaderDefaultMaxTitleWidth = 180;

double floatingPageHeaderContentTopPadding(
  BuildContext context, {
  double bottomSpacing = floatingPageHeaderBottomSpacing,
  double topGap = floatingPageHeaderTopGap,
  double headerHeight = floatingPageHeaderHeight,
}) {
  final viewPadding = MediaQuery.viewPaddingOf(context);
  return viewPadding.top + topGap + headerHeight + bottomSpacing;
}

class FloatingPageHeaderAction {
  final Widget icon;
  final VoidCallback onTap;
  final String? semanticsLabel;

  const FloatingPageHeaderAction({
    required this.icon,
    required this.onTap,
    this.semanticsLabel,
  });
}

class FloatingPageHeader extends StatelessWidget {
  final Widget child;
  final FloatingPageHeaderAction? leadingAction;
  final FloatingPageHeaderAction? trailingAction;
  final String? title;
  final double horizontalInset;
  final double spacing;
  final double topGap;
  final double maxTitleWidth;

  const FloatingPageHeader({
    super.key,
    required this.child,
    this.leadingAction,
    this.trailingAction,
    this.title,
    this.horizontalInset = floatingPageHeaderHorizontalInset,
    this.spacing = floatingPageHeaderSpacing,
    this.topGap = floatingPageHeaderTopGap,
    this.maxTitleWidth = floatingPageHeaderDefaultMaxTitleWidth,
  });

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final colors = FTheme.of(context).colors;

    return Stack(
      children: [
        child,
        Positioned(
          top: viewPadding.top + topGap,
          left: horizontalInset,
          right: horizontalInset,
          child: Row(
            children: [
              _FloatingPageHeaderActionSlot(
                action: leadingAction,
                backgroundColor: colors.card,
                borderColor: colors.border,
                iconColor: colors.foreground,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Center(
                  child: title == null
                      ? const SizedBox.shrink()
                      : _FloatingPageHeaderTitlePill(
                          backgroundColor: colors.card,
                          borderColor: colors.border,
                          textColor: colors.foreground,
                          title: title!,
                          maxWidth: maxTitleWidth,
                        ),
                ),
              ),
              SizedBox(width: spacing),
              _FloatingPageHeaderActionSlot(
                action: trailingAction,
                backgroundColor: colors.card,
                borderColor: colors.border,
                iconColor: colors.foreground,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FloatingPageHeaderActionSlot extends StatelessWidget {
  final FloatingPageHeaderAction? action;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;

  const _FloatingPageHeaderActionSlot({
    required this.action,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final action = this.action;
    if (action == null) {
      return const SizedBox.square(dimension: floatingPageHeaderHeight);
    }

    return _FloatingPageHeaderButton(
      icon: action.icon,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      iconColor: iconColor,
      onTap: action.onTap,
      semanticsLabel: action.semanticsLabel,
    );
  }
}

class _FloatingPageHeaderButton extends StatelessWidget {
  final Widget icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback onTap;
  final String? semanticsLabel;

  const _FloatingPageHeaderButton({
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.onTap,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: floatingPageHeaderHeight,
          height: floatingPageHeaderHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(color: iconColor, size: 18),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingPageHeaderTitlePill extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String title;
  final double maxWidth;

  const _FloatingPageHeaderTitlePill({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.title,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        height: floatingPageHeaderHeight,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(floatingPageHeaderHeight),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
