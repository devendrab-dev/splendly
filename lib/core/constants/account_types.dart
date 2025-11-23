import 'package:money_tracker/core/constants/app_assets.dart';

class AccountType {
  final String name;
  final List<String> logo;
  final double balance;

  const AccountType({required this.name, required this.logo, this.balance = 0});
}

const List<AccountType> accountTypes = [
  AccountType(name: "Bank", logo: [AppAssets.canara]),
  AccountType(name: "Card", logo: [AppAssets.rupayCard, AppAssets.masterCard]),
  AccountType(
    name: "UPI",
    logo: [AppAssets.googlePay, AppAssets.phonePay, AppAssets.upi],
  ),
  AccountType(name: "Cash", logo: []),
  AccountType(name: "Others", logo: []),
];
