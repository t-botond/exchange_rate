import 'dart:async';

import 'package:exchange_rate/data/floor_currency.dart';
import 'package:exchange_rate/data/floorCurrencyDao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floor_currency_database.g.dart'; // the generated code will be there

@Database(
  version: 2,
  entities: [
    FloorCurrency,
  ],
)
abstract class FloorCurrencyDatabase extends FloorDatabase {
  FloorCurrencyDao get currencyDao;
}