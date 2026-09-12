// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wills_dao.dart';

// ignore_for_file: type=lint
mixin _$WillsDaoMixin on DatabaseAccessor<SirajiDatabase> {
  $WillsTable get wills => attachedDatabase.wills;
  WillsDaoManager get managers => WillsDaoManager(this);
}

class WillsDaoManager {
  final _$WillsDaoMixin _db;
  WillsDaoManager(this._db);
  $$WillsTableTableManager get wills =>
      $$WillsTableTableManager(_db.attachedDatabase, _db.wills);
}
