import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart';
import '../navigation/route_names.dart';
import '../theme/siraji_colors.dart';
import 'siraji_header.dart';
import 'siraji_bottom_navigation.dart';

class SirajiScaffold extends StatelessWidget {
  const SirajiScaffold({
    super.key,
    required this.title,
    required this.body,
    this.titleIcon,
    this.currentNavIndex = 0,
    this.drawer,
    this.floatingActionButton,
    this.actions,
  });

  final String title;
  final IconData? titleIcon;
  final Widget body;
  final int currentNavIndex;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final navConfig = [
      (
        icon: Icons.home_outlined,
        primary: loc.navHome,
        secondary: 'Home',
        routeName: RouteNames.home,
      ),
      (
        icon: Icons.calculate_outlined,
        primary: loc.navCalculations,
        secondary: 'Calculations',
        routeName: RouteNames.calculations,
      ),
      (
        icon: Icons.auto_stories_outlined,
        primary: loc.navKnowledge,
        secondary: 'Knowledge',
        routeName: RouteNames.knowledge,
      ),
      (
        icon: Icons.bookmark_border_outlined,
        primary: loc.navReports,
        secondary: 'Reports',
        routeName: RouteNames.reports,
      ),
      (
        icon: Icons.settings_outlined,
        primary: loc.navSettings,
        secondary: 'Settings',
        routeName: RouteNames.settings,
      ),
    ];

    return Scaffold(
      backgroundColor: SirajiColors.cream,
      drawer: drawer,
      appBar: SirajiHeader(
        title: title,
        titleIcon: titleIcon,
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          Positioned.fill(child: body),
        ],
      ),
      bottomNavigationBar: SirajiBottomNavigation(
        currentIndex: currentNavIndex,
        destinations: List.generate(
          navConfig.length,
          (i) => SirajiNavDestination(
            icon: navConfig[i].icon,
            primaryLabel: navConfig[i].primary,
            secondaryLabel: navConfig[i].secondary,
          ),
        ),
        onDestinationSelected: (index) {
          if (index != currentNavIndex) {
            context.go(navConfig[index].routeName);
          }
        },
      ),
    );
  }
}
