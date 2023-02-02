
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:flutter_room_database_and_share_preferance/database/dao/bank_details_dao.dart';
import 'package:flutter_room_database_and_share_preferance/database/entity/bank_details.dart';


part 'database.g.dart'; // the generated code will be there


@Database(version: 1, entities: [BankDetails])
abstract class AppDatabase extends FloorDatabase {
  BankDetailsDao get bankDetailsDao;
}
