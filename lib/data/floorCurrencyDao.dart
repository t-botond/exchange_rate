import 'package:exchange_rate/MemoryCurrencyRepository/CurrencyRepository.dart';
import 'package:floor/floor.dart';
import 'floor_currency.dart';

@dao
abstract class FloorCurrencyDao {
  @Query('SELECT * FROM currency')
  Future<List<FloorCurrency>> getAllCurrencies();

  @Query('SELECT * FROM currency WHERE id = :id')
  Future<FloorCurrency?> getCurrency(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertCurrency(FloorCurrency currency);


  @Query("DELETE FROM currency WHERE id = :id")
  Future<void> deleteCurrency(int id);
}
