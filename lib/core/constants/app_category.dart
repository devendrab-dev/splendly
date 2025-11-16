import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_assets.dart';

class AppCategory {
  final String iconPath;
  final Color color;
  final String title;

  AppCategory({
    required this.iconPath,
    required this.color,
    required this.title,
  });
}

final List<AppCategory> incomeCategories = [
  AppCategory(
    iconPath: AppAssets.more,
    title: "Others",
    color: Color(0xFF9E9E9E), // Light Grey
  ),
  AppCategory(
    iconPath: AppAssets.income,
    title: "Salary",
    color: const Color(0xFFE53935), // Red
  ),
  AppCategory(
    iconPath: AppAssets.coupon,
    title: "Coupons",
    color: const Color(0xFF8E24AA), // Purple
  ),
  AppCategory(
    iconPath: AppAssets.gift,
    title: "Gift",
    color: const Color(0xFF1E88E5), // Blue
  ),
];

final List<AppCategory> expenseCategories = [
  AppCategory(
    iconPath: AppAssets.more,
    title: "Others",
    color: Color(0xFF9E9E9E), // Light Grey
  ),
  AppCategory(
    iconPath: AppAssets.food,
    title: "Food",
    color: const Color(0xFFE53935), // Red
  ),
  AppCategory(
    iconPath: AppAssets.shopping,
    title: "Shopping",
    color: const Color(0xFF8E24AA), // Purple
  ),
  AppCategory(
    iconPath: AppAssets.travel,
    title: "Transport",
    color: const Color(0xFF1E88E5), // Blue
  ),
  AppCategory(
    iconPath: AppAssets.entertainment,
    title: "Entertainment",
    color: const Color(0xFFFDD835), // Yellow
  ),
  AppCategory(
    iconPath: AppAssets.health,
    title: "Health",
    color: const Color(0xFF43A047), // Green
  ),
  AppCategory(
    iconPath: AppAssets.bill,
    title: "Bills",
    color: const Color(0xFFFB8C00), // Orange
  ),
  AppCategory(
    iconPath: AppAssets.education,
    title: "Education",
    color: const Color(0xFF6D4C41), // Brown
  ),
  AppCategory(
    iconPath: AppAssets.rent,
    title: "Rent",
    color: const Color(0xFF00897B), // Teal
  ),
  AppCategory(
    iconPath: AppAssets.gift,
    title: "Gifts",
    color: const Color(0xFFEC407A), // Pink
  ),
];
