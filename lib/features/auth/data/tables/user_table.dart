import 'package:drift/drift.dart';

class UserTable extends Table {
  TextColumn get id => text()();
  TextColumn get email => text().unique()();
  TextColumn get name => text()();
  TextColumn get profileImage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}