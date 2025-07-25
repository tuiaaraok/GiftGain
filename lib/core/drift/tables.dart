// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'tables.g.dart';

class Card extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get number => text()();
  TextColumn get name => text()();
  DateTimeColumn get validPeriod => dateTime()();
}

class CardDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idCard => integer().references(Card, #id)();
  IntColumn get bonus => integer()();
  DateTimeColumn get dateOperation => dateTime()();
  BoolColumn get isAddBonus => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(
  tables: [
    Card,
    CardDetail,
  ],
)
@singleton
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
