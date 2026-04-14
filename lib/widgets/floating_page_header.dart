import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

const double floatingPageHeaderHeight = 44;
const double floatingPageHeaderHorizontalInset = 12;
const double floatingPageHeaderSpacing = 10;
const double floatingPageHeaderTopGap = 10;
const double floatingPageHeaderBottomSpacing = 18;

double floatingPageHeaderContentTopPadding(
  BuildContext context, {
  double bottomSpacing = floatingPageHeaderBottomSpacing,
  double topGap = floatingPageHeaderTopGap,
  double headerHeight = floatingPageHeaderHeight,
}) {
  final viewPadding = MediaQuery.viewPaddingOf(context);
  return viewPadding.top + topGap + headerHeight + bottomSpacing;
}

class FloatingPageHeaderContent extends StatelessWidget {
  final Widget child;
  final double bottomSpacing;
  final double topGap;
  final double headerHeight;

  const FloatingPageHeaderContent({
    super.key,
    required this.child,
    this.bottomSpacing = floatingPageHeaderBottomSpacing,
    this.topGap = floatingPageHeaderTopGap,
    this.headerHeight = floatingPageHeaderHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: floatingPageHeaderContentTopPadding(
          context,
          bottomSpacing: bottomSpacing,
          topGap: topGap,
          headerHeight: headerHeight,
        ),
      ),
      child: child,
    );
  }
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
  final Widget? titleContent;
  final double horizontalInset;
  final double spacing;
  final double topGap;

  const FloatingPageHeader({
    super.key,
    required this.child,
    this.leadingAction,
    this.trailingAction,
    this.title,
    this.titleContent,
    this.horizontalInset = floatingPageHeaderHorizontalInset,
    this.spacing = floatingPageHeaderSpacing,
    this.topGap = floatingPageHeaderTopGap,
  }) : assert(
         title == null || titleContent == null,
         'Provide either title or titleContent, not both.',
       );

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final colors = FTheme.of(context).colors;
    final titleStyle = TextStyle(
      color: colors.foreground,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    );
    final resolvedTitle = titleContent ??
        (title == null ? null : Text(title!));

    return Stack(
      children: [
        child,
        Positioned(
          top: viewPadding.top + topGap,
          left: horizontalInset,
          right: horizontalInset,
          child: SizedBox(
            height: floatingPageHeaderHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FloatingPageHeaderActionSlot(
                      action: leadingAction,
                      backgroundColor: colors.card,
                      borderColor: colors.border,
                      iconColor: colors.foreground,
                    ),
                    _FloatingPageHeaderActionSlot(
                      action: trailingAction,
                      backgroundColor: colors.card,
                      borderColor: colors.border,
                      iconColor: colors.foreground,
                    ),
                  ],
                ),
                if (resolvedTitle != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: floatingPageHeaderHeight + spacing,
                    ),
                    child: Center(
                      child: DefaultTextStyle(
                        style: titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: IconTheme(
                          data: IconThemeData(
                            color: colors.foreground,
                            size: 14,
                          ),
                          child: resolvedTitle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
