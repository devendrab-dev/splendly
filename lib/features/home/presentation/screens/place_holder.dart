import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/features/accounts/presentation/screens/accounts_list.dart';
import 'package:money_tracker/features/analysis/presentation/screens/analysis_screen.dart';
import 'package:money_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:money_tracker/features/transactions/presentation/screens/transaction_screen.dart';

class PlaceHolder extends StatefulWidget {
  const PlaceHolder({super.key});

  @override
  State<PlaceHolder> createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder> {
  List<Widget> screens = [
    HomeScreen(),
    AnalysisScreen(),
    TransactionScreen(),
    AccountsList(),
    // MoreScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey600,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.barChart3),
            label: "Analysis",
          ),
          BottomNavigationBarItem(icon: Icon(LucideIcons.plus), label: "Add"),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.landmark),
            label: "Accounts",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(LucideIcons.moreHorizontal),
          //   label: "More",
          // ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
