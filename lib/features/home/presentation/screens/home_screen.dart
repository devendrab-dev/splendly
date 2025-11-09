import 'package:flutter/material.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<AccountModel> accounts = HiveAccount.getAccountsList();

    for (var acc in accounts) {
      debugPrint(
        'Name: ${acc.userName}, Type: ${acc.accountType}, Balance: ${acc.balance}, Card: ${acc.cardNumber}, Image: ${acc.imagePath}',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: accounts.isEmpty
          ? const Center(child: Text("No accounts saved"))
          : ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final acc = accounts[index];
                return ListTile(
                  title: Text(acc.userName),
                  subtitle: Text('${acc.accountType} - ₹${acc.balance}'),
                  leading: acc.imagePath.isNotEmpty
                      ? Image.asset(acc.imagePath, width: 40, height: 40)
                      : null,
                  trailing: acc.cardNumber != null
                      ? Text(acc.cardNumber.toString())
                      : null,
                );
              },
            ),
    );
  }
}
