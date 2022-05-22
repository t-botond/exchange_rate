
class Favorite {
  final String fromCurrency;
  final String toCurrency;
  Favorite(this.fromCurrency, this.toCurrency);

  factory Favorite.fromJson(Map<String, dynamic> json){
    return Favorite(json['fromCurrency'] as String, json['toCurrency'] as String);
  }


  Map<String, dynamic> toJson()=>{
    'fromCurrency':fromCurrency,
    'toCurrency': toCurrency,
  };
}