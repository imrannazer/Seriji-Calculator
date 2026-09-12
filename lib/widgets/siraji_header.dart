import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_spacing.dart';
import 'siraji_logo.dart';
import 'siraji_header_title.dart';

class SirajiHeader extends StatelessWidget implements PreferredSizeWidget {
  const SirajiHeader({
    super.key,
    required this.title,
    this.titleIcon,
    this.onMenuPressed,
    this.actions,
  });

  final String title;
  final IconData? titleIcon;
  final VoidCallback? onMenuPressed;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      const Size.fromHeight(SirajiSpacing.headerHeight);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: SirajiColors.darkGreen,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        height: SirajiSpacing.headerHeight + topPadding,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: SirajiColors.headerGradient,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRect(
                child: Opacity(
                  opacity: 0.15,
                  child: Image.asset(
                    'assets/mosque/mosque_header.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1.5,
                color: SirajiColors.gold.withOpacity(0.4),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: topPadding,
                left: SirajiSpacing.headerHorizontalPadding,
                right: SirajiSpacing.headerHorizontalPadding,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: SirajiColors.gold, size: 24),
                    onPressed: onMenuPressed ??
                        () => Scaffold.of(context).openDrawer(),
                  ),
                  Expanded(
                    child: Center(
                      child: SirajiHeaderTitle(
                        title: title,
                        icon: titleIcon,
                      ),
                    ),
                  ),
                  if (actions != null) ...actions!,
                  const SirajiLogo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
