import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/more/utils/utils.dart';
import 'package:money_tracker/features/transactions/data/providers/handle_transaction.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  Widget buildOptionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> options = [
      {
        "title": "Import Data",
        "icon": Icons.download,
        "color": Colors.blue,
        "subtitle": "Import transactions and accounts from a file",
      },
      {
        "title": "Export Data",
        "icon": Icons.upload_file,
        "color": Colors.green,
        "subtitle": "Export your transactions and accounts to a file",
      },
      {
        "title": "Backup Data",
        "icon": Icons.backup,
        "color": Colors.orange,
        "subtitle": "Create a backup of your current data",
      },
      {
        "title": "Restore Backup",
        "icon": Icons.restore,
        "color": Colors.red,
        "subtitle": "Restore data from a previous backup",
      },
      {
        "title": "Settings",
        "icon": Icons.settings,
        "color": Colors.grey,
        "subtitle": "Adjust app preferences",
      },
      {
        "title": "Help & Support",
        "icon": Icons.help_outline,
        "color": Colors.purple,
        "subtitle": "Get help or contact support",
      },
    ];
    String accountId = ref.watch(transactionFormProvider).fromAccount.accountId;
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Options", style: AppTextStyles.appBarTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: options
              .map(
                (option) => buildOptionCard(
                  context: context,
                  title: option['title'],
                  icon: option['icon'],
                  color: option['color'],
                  subtitle: option['subtitle'],
                  onTap: () => importJsonFile(context, accountId),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
