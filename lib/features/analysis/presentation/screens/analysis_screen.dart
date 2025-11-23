import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/analysis/presentation/widgets/bar_grapgh.dart';
import 'package:money_tracker/features/analysis/presentation/widgets/category_chart.dart';
import 'package:money_tracker/features/analysis/presentation/widgets/summary.dart';
import 'package:money_tracker/features/transactions/data/hive_storage.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/segement_button.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  TransactionGraphData data = TransactionGraphData(
    expense: [],
    income: [],
    label: [],
    expenseCategories: [],
    incomeCategories: [],
    summaryData: SummaryData(),
  );
  List<TransactionModel> transactionList = [];
  final List<String> labels = ["Week", "Month", "Year"];
  @override
  void initState() {
    data = HiveTransaction.getTransactionsBarListByFilter(labels[0]);
    transactionList = HiveTransaction.getTransactionsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finacial Analysis", style: AppTextStyles.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedSegmentedControl(
                labels: labels,
                onChanged: (index) {
                  setState(() {
                    data = HiveTransaction.getTransactionsBarListByFilter(
                      labels[index],
                    );
                  });
                },
              ),
              SizedBox(height: 20),
              IncomeExpenseData(
                expenseData: data.expense,
                incomeData: data.income,
                xLabels: data.label,
              ),
              CategoryPieChartDemo(
                expense: data.expenseCategories,
                income: data.incomeCategories,
              ),
              SizedBox(height: 20),
              SummaryWidget(data: data.summaryData),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
