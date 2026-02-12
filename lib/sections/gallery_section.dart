import 'package:flutter/material.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';
import 'package:website/widgets/section_title.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key, required this.imageUrls});

  final List<String> imageUrls;

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
          title: 'Gallery',
          subtitle: 'Highlights from last season and opening-day moments.',
        ),
        const SizedBox(height: 24),
        GridView.builder(
          itemCount: imageUrls.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return Container(
                    color: const Color(0xFFE5E7EB),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
