import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_assets.dart';

class ExpenseCategory {
  final String iconPath;
  final Color color;
  final String title;

  ExpenseCategory({
    required this.iconPath,
    required this.color,
    required this.title,
  });
}
final List<ExpenseCategory> expenseCategories = [
  ExpenseCategory(
    iconPath: AppAssets.food,
    title: "Food",
    color: const Color(0xFFE53935), // Red
  ),
  ExpenseCategory(
    iconPath: AppAssets.shopping,
    title: "Shopping",
    color: const Color(0xFF8E24AA), // Purple
  ),
  ExpenseCategory(
    iconPath: AppAssets.travel,
    title: "Transport",
    color: const Color(0xFF1E88E5), // Blue
  ),
  ExpenseCategory(
    iconPath: AppAssets.entertainment,
    title: "Entertainment",
    color: const Color(0xFFFDD835), // Yellow
  ),
  ExpenseCategory(
    iconPath: AppAssets.health,
    title: "Health",
    color: const Color(0xFF43A047), // Green
  ),
  ExpenseCategory(
    iconPath: AppAssets.bill,
    title: "Bills",
    color: const Color(0xFFFB8C00), // Orange
  ),
  ExpenseCategory(
    iconPath: AppAssets.education,
    title: "Education",
    color: const Color(0xFF6D4C41), // Brown
  ),
  ExpenseCategory(
    iconPath: AppAssets.rent,
    title: "Rent",
    color: const Color(0xFF00897B), // Teal
  ),
  ExpenseCategory(
    iconPath: AppAssets.gift,
    title: "Gifts",
    color: const Color(0xFFEC407A), // Pink
  ),
];
