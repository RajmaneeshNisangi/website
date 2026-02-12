import 'package:flutter/material.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';
import 'package:website/models/team_model.dart';
import 'package:website/widgets/section_title.dart';

class TeamsSection extends StatelessWidget {
  const TeamsSection({super.key, required this.teams});

  final List<TeamModel> teams;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = ResponsiveBreakpoints.isDesktop(width)
        ? 3
        : ResponsiveBreakpoints.isTablet(width)
            ? 2
            : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Teams',
          subtitle: 'Franchises competing this season with experienced captains.',
        ),
        const SizedBox(height: 24),
        GridView.builder(
          itemCount: teams.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: crossAxisCount == 1 ? 2.9 : 1.9,
          ),
          itemBuilder: (context, index) => _TeamCard(team: teams[index]),
        ),
      ],
    );
  }
}

class _TeamCard extends StatefulWidget {
  const _TeamCard({required this.team});

  final TeamModel team;

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final team = widget.team;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ]
              : const [],
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(team.primaryHexColor),
                    Color(team.secondaryHexColor),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  team.logoText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Captain: ${team.captain}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
