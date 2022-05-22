

import 'package:exchange_rate/data/floorCurrencyDao.dart';
import 'package:exchange_rate/data/floor_currency.dart';
import 'package:exchange_rate/data/FloorCurrencyDatabase.dart';
import 'CurrencyRepository.dart';

class FloorCurrencyRepository implements CurrencyRepository<FloorCurrency>{
  late FloorCurrencyDao currencyDao;
  @override
  Future<void> init() async {
    /*final database = await $FloorCurrencyDatabase
        .databaseBuilder("floor_currency.db")
        .build(); // This is how we can initialize our database
    currencyDao = database.currencyDao; // But practically we're using DAOs to manipulate data in it
    */
  }

  @override
  Future<void> deleteCurrency(FloorCurrency currency) {
    return currencyDao.deleteCurrency(currency.id??-1);
  }

  @override
  Future<List<FloorCurrency>> getAllCurrencies() {
    return currencyDao.getAllCurrencies();
  }

  @override
  Future<FloorCurrency> getCurrency(int id)async {
    final currency = await currencyDao.getCurrency(id);
    if(currency == null) {
      throw Exception("Invalid TODO ID");
    } else {
      return currency;
    }
  }



  @override
  Future<void> upsertCurrency(FloorCurrency currency) {
    return currencyDao.upsertCurrency(currency);
  }


}