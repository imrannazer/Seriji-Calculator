import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../navigation/route_names.dart';
import '../../theme/siraji_colors.dart';
import '../../theme/siraji_typography.dart';
import '../../theme/siraji_spacing.dart';
import '../../core/constants/app_constants.dart';

/// Siraji splash / launch screen.
///
/// Visual rules (faithfully implemented, pending actual assets):
/// - Full-screen deep-green background
/// - Subtle Islamic geometric pattern overlay
/// - Siraji logo centered — never stretched or distorted
/// - Urdu/Arabic branding
/// - English subtitle
/// - Three feature indicators
/// - Gold detailing
/// - Animated loading progress bar
/// - Transitions to LanguageScreen on complete
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: AppConstants.splashDurationMs),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _progressAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.95, curve: Curves.easeInOut),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.go(RouteNames.language);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SirajiColors.deepGreen,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          const DecoratedBox(
            decoration: BoxDecoration(gradient: SirajiColors.splashGradient),
          ),
          // Islamic pattern overlay
          Opacity(
            opacity: 0.06,
            child: Image.asset(
              'assets/images/islamic_pattern.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          // Mosque imagery (upper portion only)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.32,
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(
                'assets/mosque/mosque_splash.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          // Main content
          FadeTransition(
            opacity: _fadeIn,
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  // Logo area
                  _SirajiSplashLogo(),
                  const SizedBox(height: SirajiSpacing.lg),
                  // Urdu title
                  Text(
                    'سراجی',
                    style: SirajiTypography.urduDisplay.copyWith(
                      color: SirajiColors.gold,
                      fontSize: 42,
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.xs),
                  // Arabic subtitle
                  Text(
                    'علم الفرائض',
                    style: SirajiTypography.arabicHeadline.copyWith(
                      color: SirajiColors.textOnDark.withOpacity(0.85),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: SirajiSpacing.sm),
                  // English tagline
                  Text(
                    'Islamic Inheritance Made Clear',
                    style: SirajiTypography.bodyMedium.copyWith(
                      color: SirajiColors.textOnDark.withOpacity(0.7),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(flex: 1),
                  // Feature indicators
                  _FeatureIndicators(),
                  const Spacer(flex: 2),
                  // Progress bar
                  _SplashProgressBar(progress: _progressAnim),
                  const SizedBox(height: SirajiSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SirajiSplashLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SirajiColors.goldGradient,
        boxShadow: [
          BoxShadow(
            color: SirajiColors.gold.withOpacity(0.4),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/logos/siraji_logo.png',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Center(
            child: Text(
              'سراجی',
              style: TextStyle(
                fontFamily: 'NotoNastaliqUrdu',
                color: SirajiColors.darkGreen,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const features = [
      (icon: Icons.calculate_outlined, label: 'Faraid'),
      (icon: Icons.article_outlined, label: 'Wills'),
      (icon: Icons.description_outlined, label: 'Reports'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: features
          .map((f) => _FeatureChip(icon: f.icon, label: f.label))
          .toList(),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: SirajiSpacing.sm),
      padding: const EdgeInsets.symmetric(
          horizontal: SirajiSpacing.md, vertical: SirajiSpacing.sm),
      decoration: BoxDecoration(
        border: Border.all(
            color: SirajiColors.gold.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(20),
        color: SirajiColors.gold.withOpacity(0.08),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: SirajiColors.gold, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: SirajiTypography.labelSmall.copyWith(
              color: SirajiColors.textOnDark.withOpacity(0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar({required this.progress});
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SirajiSpacing.xxl),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: progress,
            builder: (_, __) => LinearProgressIndicator(
              value: progress.value,
              backgroundColor: SirajiColors.textOnDark.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  SirajiColors.gold),
              minHeight: 3,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
