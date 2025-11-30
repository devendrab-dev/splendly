import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/widgets/app_message.dart';
import 'package:money_tracker/features/transactions/data/hive_storage.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

Future<void> importJsonFile(BuildContext context, String accountId) async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: .custom,
      allowedExtensions: ["json"],
    );

    if (result == null) {
      debugPrint("No file selected");
      return;
    }

    final file = File(result.files.single.path!);
    final jsonString = await file.readAsString();
    final jsonData = jsonDecode(jsonString);

    if (jsonData["transactions"] == null) {
      debugPrint("Invalid JSON: 'transactions' key missing");
      if (!context.mounted) return;
      showModernSnackBar(
        context: context,
        message: "Invalid JSON: 'transactions' key missing",
        type: .error,
      );
      return;
    }
    List<TransactionModel> rawList = HiveTransaction.getTransactionsList();

    final existingIds = rawList.map((item) => item.id).toSet();

    int importedCount = 0;

    for (var map in jsonData["transactions"]) {
      final id = map["id"];

      if (existingIds.contains(id)) {
        debugPrint("Duplicate skipped: $id");
        continue;
      }

      final parsedDate = DateFormat("yyyy-MM-dd HH:mm").parse(map["dateTime"]);

      final newTx = TransactionModel(
        amount: map["amount"],
        category: map["category"],
        dateTime: parsedDate,
        fromAccountId: accountId,
        iconPath: AppAssets.others,
        id: map["id"],
        note: map["note"],
        transactionType: map["transactionType"],
      );

      rawList.add(newTx);
      importedCount++;
    }
    await HiveTransaction.saveTransactionsList([]);
    debugPrint("Imported $importedCount transaction(s)");
    if (!context.mounted) return;
    showModernSnackBar(
      context: context,
      message: "Imported $importedCount transactions",
      type: .success,
    );
  } catch (e) {
    debugPrint("Import failed: $e");
    showModernSnackBar(
      context: context,
      message: "Imported Failed",
      type: .error,
    );
  }
}
