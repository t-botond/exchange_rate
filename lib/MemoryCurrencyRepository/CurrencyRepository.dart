

abstract class CurrencyRepository<T> {
  Future<void> init();

  Future<List<T>> getAllCurrencies();

  Future<T> getCurrency(int id);

  Future<void> upsertCurrency(T currency);

  Future<void> deleteCurrency(T currency);
}