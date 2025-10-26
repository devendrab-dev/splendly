import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/features/onboarding/data/models/onboard_model.dart';

final List<OnBoardModel> onboardData = [
  OnBoardModel(
    image: AppAssets.onboard1,
    title: 'Gain total control of your money',
    description: 'Become your own money manager and make every cent count',
  ),
  OnBoardModel(
    image: AppAssets.onboard2,
    title: 'Know where your money goes',
    description: 'Track your transaction easily, with categories and financial report',
  ),
  OnBoardModel(
    image: AppAssets.onboard3,
    title: 'Planning ahead',
    description: 'Setup your budget for each category so you in control',
  ),
];
