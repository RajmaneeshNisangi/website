import 'dart:async';

import 'package:flutter/material.dart';
import 'package:website/core/constants/app_constants.dart';
import 'package:website/core/constants/app_data.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onViewSchedule,
    required this.onViewTeams,
  });

  final VoidCallback onViewSchedule;
  final VoidCallback onViewTeams;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late final PageController _pageController;
  Timer? _timer;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      final nextIndex = (_activeIndex + 1) % AppData.heroImages.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    if (_activeIndex == index) {
      return;
    }
    setState(() {
      _activeIndex = index;
    });
  }

  void _jumpTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
    _startAutoSlide();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = ResponsiveBreakpoints.isMobile(width);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - value)),
          child: child,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 40,
          vertical: isMobile ? 36 : 48,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF0A84FF), Color(0xFF00467F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: isMobile ? _mobileLayout(context) : _desktopLayout(context),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _textContent(context)),
        const SizedBox(width: 32),
        Expanded(child: _heroSliderCard()),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textContent(context),
        const SizedBox(height: 28),
        _heroSliderCard(height: 240),
      ],
    );
  }

  Widget _textContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.tournamentName,
          style: textTheme.displayMedium?.copyWith(
            color: Colors.white,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.season,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on_rounded, color: Colors.white70, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                AppConstants.location,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: widget.onViewSchedule,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF00467F),
              ),
              child: const Text('View Schedule'),
            ),
            OutlinedButton(
              onPressed: widget.onViewTeams,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
              child: const Text('Teams'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _heroSliderCard({double height = 300}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: AppData.heroImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  AppData.heroImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 14,
              child: _slideButton(
                icon: Icons.chevron_left_rounded,
                onTap: () {
                  final prev =
                      (_activeIndex - 1 + AppData.heroImages.length) %
                      AppData.heroImages.length;
                  _jumpTo(prev);
                },
              ),
            ),
            Positioned(
              right: 14,
              top: 14,
              child: _slideButton(
                icon: Icons.chevron_right_rounded,
                onTap: () {
                  final next = (_activeIndex + 1) % AppData.heroImages.length;
                  _jumpTo(next);
                },
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tournament Window',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'March 12 - April 2, 2026',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: List.generate(
                      AppData.heroImages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: index == _activeIndex ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index == _activeIndex
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slideButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white.withValues(alpha: 0.24),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
