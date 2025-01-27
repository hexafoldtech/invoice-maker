import 'package:drift/drift.dart';

class Client extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientPhoneNumber => text().named('client_phone_no')();
  TextColumn get clientEmailId => text().named('client_email_id')();
  TextColumn get clientAddress => text().named('client_address')();
}
