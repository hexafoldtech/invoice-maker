import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:invoice_maker/data/local/entity/new_client_entity.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart" as path;
// part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'clients.sqlite'));

    return NativeDatabase(file);
  });
}

// @DriftDatabase(tables: [Client])
// class AppDatabase extends _$AppDb {
//   AppDatabase() : super(_openConnection());

//   @override
//   int get schemaVersion => 1;
// }
