import 'package:flutter/material.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';
import 'package:website/models/match_model.dart';
import 'package:website/widgets/section_title.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key, required this.matches});

  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = ResponsiveBreakpoints.isDesktop(width)
        ? 2
        : ResponsiveBreakpoints.isTablet(width)
            ? 2
            : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Match Schedule',
          subtitle: 'Full fixture list with date, venue, and match status.',
        ),
        const SizedBox(height: 24),
        GridView.builder(
          itemCount: matches.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: columns == 1 ? 2.0 : 2.2,
          ),
          itemBuilder: (context, index) => _MatchCard(match: matches[index]),
        ),
      ],
    );
  }
}

class _MatchCard extends StatefulWidget {
  const _MatchCard({required this.match});

  final MatchModel match;

  @override
  State<_MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<_MatchCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final match = widget.match;
    final isUpcoming = match.status == MatchStatus.upcoming;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 170),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${match.teamA} vs ${match.teamB}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StatusBadge(isUpcoming: isUpcoming),
              ],
            ),
            Text(_formatDateTime(match.dateTime)),
            Text('Venue: ${match.venue}'),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour12 = dateTime.hour == 0
        ? 12
        : dateTime.hour > 12
            ? dateTime.hour - 12
            : dateTime.hour;
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, $hour12:$minute $amPm';
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isUpcoming});

  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    final color = isUpcoming ? const Color(0xFF0369A1) : const Color(0xFF166534);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        isUpcoming ? 'Upcoming' : 'Completed',
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
