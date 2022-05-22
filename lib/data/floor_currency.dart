import 'package:floor/floor.dart';


@Entity(tableName: 'currency')
class FloorCurrency {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String fromCurrency;
  String toCurrency;

  FloorCurrency({
    this.id,
    required this.fromCurrency,
    required this.toCurrency,
  });
}