import 'package:flutter/material.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';
import 'package:website/widgets/section_title.dart';

class SponsorsSection extends StatelessWidget {
  const SponsorsSection({super.key, required this.sponsors});

  final List<String> sponsors;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = ResponsiveBreakpoints.isDesktop(width)
        ? 5
        : ResponsiveBreakpoints.isTablet(width)
            ? 3
            : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Sponsors',
          subtitle: 'Partners supporting the tournament and local cricket growth.',
        ),
        const SizedBox(height: 22),
        GridView.builder(
          itemCount: sponsors.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 2.6,
          ),
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Text(
                sponsors[index],
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ],
    );
  }
}
