import 'package:flutter/material.dart';
import '../theme/siraji_colors.dart';
import '../theme/siraji_spacing.dart';
import 'siraji_navigation_item.dart';
import 'siraji_selected_nav_item.dart';

class SirajiNavDestination {
  const SirajiNavDestination({
    required this.icon,
    required this.primaryLabel,
    required this.secondaryLabel,
  });
  final IconData icon;
  final String primaryLabel;
  final String secondaryLabel;
}

class SirajiBottomNavigation extends StatelessWidget {
  const SirajiBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<SirajiNavDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: SirajiSpacing.footerMarginHorizontal,
        right: SirajiSpacing.footerMarginHorizontal,
        bottom: SirajiSpacing.footerMarginBottom + bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SirajiSpacing.footerHeight,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  SirajiColors.darkGreen,
                  SirajiColors.deepGreen,
                  SirajiColors.mediumGreen,
                  SirajiColors.deepGreen,
                  SirajiColors.darkGreen,
                ],
              ),
              borderRadius:
                  BorderRadius.circular(SirajiSpacing.footerBorderRadius),
              border: Border.all(
                color: SirajiColors.gold.withOpacity(0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: SirajiColors.darkGreen.withOpacity(0.5),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        SirajiSpacing.footerBorderRadius),
                    child: Opacity(
                      opacity: 0.12,
                      child: Image.asset(
                        'assets/mosque/mosque_footer.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SirajiSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(destinations.length, (index) {
                      final dest = destinations[index];
                      if (index == currentIndex) {
                        return SirajiSelectedNavigationItem(
                          icon: dest.icon,
                          primaryLabel: dest.primaryLabel,
                          secondaryLabel: dest.secondaryLabel,
                          onTap: () => onDestinationSelected(index),
                        );
                      }
                      return SirajiNavigationItem(
                        icon: dest.icon,
                        primaryLabel: dest.primaryLabel,
                        secondaryLabel: dest.secondaryLabel,
                        onTap: () => onDestinationSelected(index),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '— ❖  © 2024 Siraji App   |   جميع الحقوق محفوظة  ❖ —',
            style: TextStyle(
              fontSize: 9,
              color: SirajiColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
