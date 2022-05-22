//import 'package:http/http.dart';

class HttpService {
  final String postsURL = "https://api.coingate.com/v2/rates/merchant/";

  Future<String> getCurrency(String from, String to) async {
    /*
    Response res = await get(postsURL+from+"/"+to);
    if (res.statusCode == 200) {
      return res.body;
    }else {
      return "Error: No internet connection";
    }
     */
    return "";
  }
}