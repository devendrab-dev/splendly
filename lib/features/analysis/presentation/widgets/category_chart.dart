import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class CategoryPieChartDemo extends StatefulWidget {
  const CategoryPieChartDemo({
    super.key,
    required this.income,
    required this.expense,
  });

  final List<Categories> income;
  final List<Categories> expense;

  @override
  State<CategoryPieChartDemo> createState() => _CategoryPieChartDemoState();
}

class _CategoryPieChartDemoState extends State<CategoryPieChartDemo> {
  String selectedType = "Expense";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Categories> dataMap = selectedType == "Expense"
        ? widget.expense
        : widget.income;
    final hasData = dataMap.isNotEmpty;
    final total = dataMap.fold(0.0, (p, e) => p + e.total);

    final sections = hasData
        ? dataMap.map((e) {
            final percent = total == 0 ? 0.0 : (e.total / total * 100);
            final color =
                Colors.primaries[e.hashCode % Colors.primaries.length];
            return PieChartSectionData(
              value: e.total,
              color: color,
              title: "${percent.toStringAsFixed(0)}%",
              radius: 50,
              titleStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList()
        : [
            PieChartSectionData(
              value: 1,
              color: Colors.grey.shade300,
              title: "",
              radius: 50,
              titleStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedType,
                    items: ["Expense", "Income"]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedType = value;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 36,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (hasData)
            Column(
              children: dataMap.map((e) {
                final color =
                    Colors.primaries[e.hashCode % Colors.primaries.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(width: 14, height: 14, color: color),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          e.category,
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                      ),
                      Text(
                        "₹${e.total.toStringAsFixed(2)}",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          if (!hasData)
            Center(
              child: Text(
                "No data available",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
