import 'package:flutter/material.dart';
import 'package:website/core/constants/app_constants.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.horizontalPadding,
  });

  final Widget child;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padding = horizontalPadding ??
        (width < 600
            ? AppConstants.horizontalPaddingMobile
            : AppConstants.horizontalPaddingDesktop);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: child,
        ),
      ),
    );
  }
}
