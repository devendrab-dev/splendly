import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeExpenseData extends StatelessWidget {
  const IncomeExpenseData({
    super.key,
    required this.incomeData,
    required this.expenseData,
    required this.xLabels,
  });

  final List<double> incomeData;
  final List<double> expenseData;
  final List<String> xLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasData = incomeData.isNotEmpty || expenseData.isNotEmpty;
    final displayIncome = hasData
        ? incomeData
        : List<double>.filled(xLabels.length, 0);
    final displayExpense = hasData
        ? expenseData
        : List<double>.filled(xLabels.length, 0);
    final maxYValue = hasData
        ? [...incomeData, ...expenseData].reduce((a, b) => a > b ? a : b) * 1.2
        : 100.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxYValue,
              clipData: FlClipData.all(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 100,
                    getTitlesWidget: (value, meta) => Text(
                      "₹${value.toInt()}",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < xLabels.length) {
                        return Text(
                          xLabels[index],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 100,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  top: BorderSide.none,
                  right: BorderSide.none,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    displayIncome.length,
                    (i) => FlSpot(i.toDouble(), displayIncome[i]),
                  ),
                  isCurved: true,
                  color: theme.colorScheme.primary,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(show: true),
                ),
                LineChartBarData(
                  spots: List.generate(
                    displayExpense.length,
                    (i) => FlSpot(i.toDouble(), displayExpense[i]),
                  ),
                  isCurved: true,
                  color: Colors.red.shade400,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade400.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(show: true),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final label = spot.barIndex == 0 ? "Income" : "Expense";
                      return LineTooltipItem(
                        "$label: ₹${spot.y.toStringAsFixed(2)}",
                        GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
        if (!hasData)
          Text(
            "No data available",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
