import 'package:hive/hive.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 1;

  @override
  TransactionType read(BinaryReader reader) {
    final value = reader.readByte();
    switch (value) {
      case 0:
        return .expense;
      case 1:
        return .income;
      case 2:
        return .transfer;
      default:
        return .expense;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    switch (obj) {
      case .expense:
        writer.writeByte(0);
        break;
      case .income:
        writer.writeByte(1);
        break;
      case .transfer:
        writer.writeByte(2);
        break;
    }
  }
}
