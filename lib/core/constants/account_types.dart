import 'package:money_tracker/core/constants/app_assets.dart';

class AccountType {
  final String name;
  final List<String> logo;

  const AccountType({required this.name, required this.logo});
}

const List<AccountType> accountTypes = [
  AccountType(name: "Canara Bank", logo: [AppAssets.google]),
  AccountType(name: "Debit Card", logo: [AppAssets.google]),
  AccountType(name: "Others", logo: [AppAssets.google]),
];
