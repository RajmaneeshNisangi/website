import 'package:flutter/material.dart';
import 'package:website/core/constants/app_data.dart';
import 'package:website/widgets/section_title.dart';

class PointsTableSection extends StatelessWidget {
  const PointsTableSection({super.key, required this.rows});

  final List<PointsTableRowData> rows;

  @override
  Widget build(BuildContext context) {
    final headerColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Points Table',
          subtitle: 'Updated standings based on wins, losses, and net run rate.',
        ),
        const SizedBox(height: 22),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              children: [
                Container(
                  color: headerColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: const Row(
                    children: [
                      _TableCell(flex: 4, text: 'Team', bold: true, header: true),
                      _TableCell(flex: 1, text: 'P', bold: true, header: true),
                      _TableCell(flex: 1, text: 'W', bold: true, header: true),
                      _TableCell(flex: 1, text: 'L', bold: true, header: true),
                      _TableCell(
                        flex: 2,
                        text: 'NRR',
                        bold: true,
                        header: true,
                      ),
                      _TableCell(
                        flex: 2,
                        text: 'PTS',
                        bold: true,
                        header: true,
                      ),
                    ],
                  ),
                ),
                ...rows.asMap().entries.map((entry) {
                  final index = entry.key;
                  final row = entry.value;
                  return Container(
                    color: index.isEven
                        ? Colors.white
                        : const Color(0xFFF8FAFC),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Row(
                      children: [
                        _TableCell(flex: 4, text: row.team, bold: true),
                        _TableCell(flex: 1, text: row.played.toString()),
                        _TableCell(flex: 1, text: row.wins.toString()),
                        _TableCell(flex: 1, text: row.losses.toString()),
                        _TableCell(
                          flex: 2,
                          text: row.netRunRate >= 0
                              ? '+${row.netRunRate.toStringAsFixed(2)}'
                              : row.netRunRate.toStringAsFixed(2),
                        ),
                        _TableCell(
                          flex: 2,
                          text: row.points.toString(),
                          bold: true,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({
    required this.flex,
    required this.text,
    this.bold = false,
    this.header = false,
  });

  final int flex;
  final String text;
  final bool bold;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: header ? Colors.white : const Color(0xFF1F2937),
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}
