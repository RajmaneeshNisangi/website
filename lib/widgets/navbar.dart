import 'package:flutter/material.dart';
import 'package:website/core/constants/app_constants.dart';
import 'package:website/core/constants/responsive_breakpoints.dart';
import 'package:website/widgets/responsive_wrapper.dart';

class NavItemData {
  const NavItemData({required this.id, required this.label});

  final String id;
  final String label;
}

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
    required this.items,
    required this.onItemTap,
    this.selectedId,
    this.elevated = false,
  });

  final List<NavItemData> items;
  final ValueChanged<String> onItemTap;
  final String? selectedId;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = ResponsiveBreakpoints.isMobile(width);

    return Container(
      height: AppConstants.navbarHeight,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.8),
          ),
        ),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: ResponsiveWrapper(
        child: Row(
          children: [
            Text(
              'Cricket Cup',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            if (isMobile)
              PopupMenuButton<String>(
                icon: const Icon(Icons.menu_rounded),
                onSelected: onItemTap,
                itemBuilder: (context) {
                  return items
                      .map(
                        (item) => PopupMenuItem<String>(
                          value: item.id,
                          child: Text(item.label),
                        ),
                      )
                      .toList();
                },
              )
            else
              Wrap(
                spacing: 8,
                children: items
                    .map(
                      (item) => _NavButton(
                        label: item.label,
                        selected: selectedId == item.id,
                        onTap: () => onItemTap(item.id),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: widget.selected || _hovered
              ? colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: widget.onTap,
          style: TextButton.styleFrom(
            foregroundColor:
                widget.selected ? colorScheme.primary : const Color(0xFF334155),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
