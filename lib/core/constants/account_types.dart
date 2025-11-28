import 'package:money_tracker/core/constants/app_assets.dart';

class AccountType {
  final String name;
  final List<Account> options;
  final double balance;

  const AccountType({
    required this.name,
    required this.options,
    this.balance = 0,
  });
}

class Account {
  final String name;
  final String logo;

  Account({required this.logo, required this.name});
}

List<AccountType> accountTypes = [
  AccountType(
    name: "Bank",
    options: [
      Account(name: "Airtel Payments Bank", logo: AppAssets.airtel),
      Account(name: "Axis Bank", logo: AppAssets.axis),
      Account(name: "Bank of Baroda", logo: AppAssets.bob),
      Account(name: "Canara Bank", logo: AppAssets.canara),
      Account(name: "Federal Bank", logo: AppAssets.federal),
      Account(name: "HDFC Bank", logo: AppAssets.hdfc),
      Account(name: "ICICI Bank", logo: AppAssets.icici),
      Account(name: "Jio Payments Bank", logo: AppAssets.jio),
      Account(name: "Karnataka Bank", logo: AppAssets.karnataka),
      Account(name: "Kotak Mahindra Bank", logo: AppAssets.kotak),
      Account(name: "Karur Vysya Bank (KVB)", logo: AppAssets.kvb),
      Account(name: "State Bank of India (SBI)", logo: AppAssets.sbi),
      Account(name: "Union Bank of India", logo: AppAssets.union),
      Account(name: "YES Bank", logo: AppAssets.yes),
    ],
  ),
  AccountType(
    name: "Card",
    options: [
      Account(name: "Visa", logo: AppAssets.visaCard),
      Account(name: "MasterCard", logo: AppAssets.masterCard),
      Account(name: "RuPay", logo: AppAssets.rupayCard),
    ],
  ),
  AccountType(
    name: "UPI",
    options: [
      Account(name: "Google Pay", logo: AppAssets.googlePay),
      Account(name: "PhonePe", logo: AppAssets.phonepe),
      Account(name: "Paytm", logo: AppAssets.paytm),
      Account(name: "BHIM UPI", logo: AppAssets.bhim),
      Account(name: "Amazon Pay", logo: AppAssets.amazonPay),
    ],
  ),
  AccountType(
    name: "Cash",
    options: [Account(name: "Cash in Hand", logo: AppAssets.cash)],
  ),
];
