import 'package:flutter/material.dart';
import 'package:website/core/constants/app_constants.dart';
import 'package:website/core/constants/app_data.dart';
import 'package:website/sections/about_tournament_section.dart';
import 'package:website/sections/footer_section.dart';
import 'package:website/sections/gallery_section.dart';
import 'package:website/sections/hero_section.dart';
import 'package:website/sections/points_table_section.dart';
import 'package:website/sections/schedule_section.dart';
import 'package:website/sections/sponsors_section.dart';
import 'package:website/sections/teams_section.dart';
import 'package:website/widgets/navbar.dart';
import 'package:website/widgets/responsive_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String hero = 'hero';
  static const String about = 'about';
  static const String teams = 'teams';
  static const String schedule = 'schedule';
  static const String points = 'points';
  static const String gallery = 'gallery';
  static const String sponsors = 'sponsors';
  static const String footer = 'footer';

  final ScrollController _scrollController = ScrollController();

  late final Map<String, GlobalKey> _sectionKeys = {
    hero: GlobalKey(),
    about: GlobalKey(),
    teams: GlobalKey(),
    schedule: GlobalKey(),
    points: GlobalKey(),
    gallery: GlobalKey(),
    sponsors: GlobalKey(),
    footer: GlobalKey(),
  };

  late final List<NavItemData> _navItems = const [
    NavItemData(id: hero, label: 'Home'),
    NavItemData(id: about, label: 'About'),
    NavItemData(id: teams, label: 'Teams'),
    NavItemData(id: schedule, label: 'Schedule'),
    NavItemData(id: points, label: 'Points Table'),
    NavItemData(id: gallery, label: 'Gallery'),
    NavItemData(id: sponsors, label: 'Sponsors'),
    NavItemData(id: footer, label: 'Contact'),
  ];

  String _selectedId = hero;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;
    final shouldElevate = currentOffset > 6;
    String? closest;
    double bestDistance = double.infinity;

    for (final entry in _sectionKeys.entries) {
      final context = entry.value.currentContext;
      if (context == null) {
        continue;
      }

      final box = context.findRenderObject() as RenderBox;
      final topOffset = box.localToGlobal(Offset.zero).dy;
      final distance = (topOffset - AppConstants.navbarHeight - 20).abs();

      if (distance < bestDistance) {
        bestDistance = distance;
        closest = entry.key;
      }
    }

    if (closest == null) {
      if (_isScrolled != shouldElevate) {
        setState(() {
          _isScrolled = shouldElevate;
        });
      }
      return;
    }

    if (closest != _selectedId || _isScrolled != shouldElevate) {
      setState(() {
        _selectedId = closest!;
        _isScrolled = shouldElevate;
      });
    }
  }

  Future<void> _scrollToSection(String sectionId) async {
    final context = _sectionKeys[sectionId]?.currentContext;
    if (context == null) {
      return;
    }

    final box = context.findRenderObject() as RenderBox;
    final local = box.localToGlobal(Offset.zero);
    final target = _scrollController.offset + local.dy - AppConstants.navbarHeight - 12;

    await _scrollController.animateTo(
      target.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: AppConstants.navbarHeight + 20),
                _section(
                  key: _sectionKeys[hero]!,
                  child: HeroSection(
                    onViewSchedule: () => _scrollToSection(schedule),
                    onViewTeams: () => _scrollToSection(teams),
                  ),
                ),
                _section(
                  key: _sectionKeys[about]!,
                  child: const AboutTournamentSection(),
                ),
                _section(
                  key: _sectionKeys[teams]!,
                  child: const TeamsSection(teams: AppData.teams),
                ),
                _section(
                  key: _sectionKeys[schedule]!,
                  child: ScheduleSection(matches: AppData.matches),
                ),
                _section(
                  key: _sectionKeys[points]!,
                  child: const PointsTableSection(rows: AppData.pointsTableRows),
                ),
                _section(
                  key: _sectionKeys[gallery]!,
                  child: const GallerySection(imageUrls: AppData.galleryImages),
                ),
                _section(
                  key: _sectionKeys[sponsors]!,
                  child: const SponsorsSection(sponsors: AppData.sponsors),
                ),
                _section(
                  key: _sectionKeys[footer]!,
                  bottomSpacing: 36,
                  child: const FooterSection(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Navbar(
              items: _navItems,
              selectedId: _selectedId,
              elevated: _isScrolled,
              onItemTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({
    required Key key,
    required Widget child,
    double bottomSpacing = AppConstants.sectionSpacing,
  }) {
    return Container(
      key: key,
      margin: EdgeInsets.only(bottom: bottomSpacing),
      child: ResponsiveWrapper(child: child),
    );
  }
}
