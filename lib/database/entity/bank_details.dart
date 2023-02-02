

import 'package:floor/floor.dart';

@entity
class BankDetails {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? itemId;

  final String? itemValue;

  final String? itemCode;

  BankDetails(this.itemId, this.id, this.itemValue, this.itemCode);

  @override
  int get hashCode =>
      id.hashCode ^ itemId.hashCode ^ itemValue.hashCode ^ itemCode.hashCode;

  @override
  String toString() {
    if (itemValue == null) {
      return "";
    } else {
      return itemValue!;
    }
  }
}