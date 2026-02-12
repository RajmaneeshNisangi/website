import 'package:flutter/material.dart';
import 'package:website/core/constants/app_constants.dart';
import 'package:website/widgets/section_title.dart';

class AboutTournamentSection extends StatelessWidget {
  const AboutTournamentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'About The Tournament',
          subtitle:
              'City Champions Cricket Cup is a premier city-level T20 tournament where emerging and experienced players compete in a high-intensity format. The event promotes professional standards, grassroots talent, and a strong local cricket culture.',
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            children: [
              const Icon(Icons.emoji_events_rounded, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Organized by ${AppConstants.organizedBy}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
