import 'package:http/http.dart';

class HttpService {
  final String postsURL = "https://api.coingate.com/v2/rates/merchant/";

  Future<String> getCurrencyFuture(Future<String> fromCurrency,Future<String> toCurrency) async {
    String from=await fromCurrency;
    String to=await toCurrency;
    Response res = await get(postsURL+from+"/"+to);
    if (res.statusCode == 200) {
      return res.body;
    }else {
      return "Error: No internet connection";
    }
  }

  Future<String> getCurrency(String fromCurrency,String toCurrency) async {
    Response res = await get(postsURL+fromCurrency+"/"+toCurrency);
    if (res.statusCode == 200) {
      return res.body;
    }else {
      return "Error: No internet connection";
    }
  }
}