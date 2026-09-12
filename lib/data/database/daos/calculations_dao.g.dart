// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculations_dao.dart';

// ignore_for_file: type=lint
mixin _$CalculationsDaoMixin on DatabaseAccessor<SirajiDatabase> {
  $CalculationsTable get calculations => attachedDatabase.calculations;
  CalculationsDaoManager get managers => CalculationsDaoManager(this);
}

class CalculationsDaoManager {
  final _$CalculationsDaoMixin _db;
  CalculationsDaoManager(this._db);
  $$CalculationsTableTableManager get calculations =>
      $$CalculationsTableTableManager(_db.attachedDatabase, _db.calculations);
}
