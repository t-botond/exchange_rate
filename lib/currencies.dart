import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_service.dart';
import 'package:exchange_rate/Widgets/ListItem.dart';
import 'data/Favorite.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);
  @override
  _CurrencyPage createState() => _CurrencyPage();
}




class _CurrencyPage extends State<CurrencyPage> {
  static const CURRENCY_FROM ="CurrencyFrom";
  static const CURRENCY_TO ="CurrencyTo";

  final HttpService httpService = HttpService();
  final items = ['EUR','USD','HUF','BTC','GBP','PLN','CZK','SEK','NOK','DKK','CHF','ZAR','AUD','JPY','NZD','TRY','BRL','CAD','CNY','HKD','INR','ILS','MYR','MXN','SGD','RON','IDR','PHP','ARS','THB','NGN','PKR','AED','UAH','BGN','HRK','RSD','LTC','ETH','BCH','XRP','CLP','XNO','TRX','DAI','DOGE','USDT','BTCV','KRW','EGP','SAR','QAR','ADA','BUSD'];
  String selectedFromCurrency = 'EUR';
  String selectedToCurrency = 'HUF';

  List<Favorite> favorites = [Favorite("USD", "BTC"), Favorite("EUR", "HUF")];

  bool isStarred=false;


  Future<String>getStoredCurrency(String key)async{
    final prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(key)?? 'EUR';
    return res;
  }
  void setStoredCurrency(String key,String value)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currencies"),
      ),
      body:
      Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Text(
            "Exchange rate",
              style: TextStyle(fontSize: 24.0 ,fontWeight:FontWeight.bold,color: Colors.black)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: getStoredCurrency(CURRENCY_FROM),
                  builder:( BuildContext context, value){
                    if(value.hasData){
                      selectedFromCurrency = value.data.toString();
                      return DropdownButton(
                        value: selectedFromCurrency,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFromCurrency = newValue!;
                            setStoredCurrency(CURRENCY_FROM, selectedFromCurrency);
                          });
                        },
                      );
                    }else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
              const Icon(
                Icons.arrow_right_alt,
                color: Colors.black,
                size: 30.0,
              ),

              FutureBuilder(
                future: getStoredCurrency(CURRENCY_TO),
                builder:( BuildContext context, value){
                  if(value.hasData){
                    selectedToCurrency = value.data.toString();
                    return DropdownButton(
                      value: selectedToCurrency,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedToCurrency = newValue!;
                          setStoredCurrency(CURRENCY_TO, selectedToCurrency);
                        });
                      },
                    );
                  }else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                    icon: isStarred ? const Icon(Icons.star) : const Icon(Icons.star_outline),
                    color:Colors.black45,
                    onPressed: (){
                      setState(() {
                        isStarred = !isStarred;
                      });
                    },
                ),
              ),

            ],
          ),
          FutureBuilder(
            future: httpService.getCurrencyFuture(getStoredCurrency(CURRENCY_FROM), getStoredCurrency(CURRENCY_TO)),
            builder: (BuildContext context,value) {
              if (value.hasData) {
                String currency = value.data.toString();
                return Text(
                    'Exchange rate: $currency',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18.0 ,fontWeight:FontWeight.bold,color: Colors.black)
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Divider(
            color: Colors.black,
            height: 20.0,
          ),
          Expanded(
            child:ListView.builder(
              itemCount: favorites.length,
              itemBuilder:(context, index){
                Favorite f= favorites[index];
                return CurrancyCard(fromCurrancy: f.fromCurrency, toCurrancy: f.toCurrency,);
              }
            ),
          ),
          /*
          ListView(
            children: const [
              Card(
                  child: ListTile(
                    title:Text("List Item 1") ,
                  )
              ),
            ],
            scrollDirection: Axis.vertical,
          ),*/
        ])
      ),
    );
  }
}