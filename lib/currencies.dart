import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_service.dart';

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
                child: const Icon(
                    Icons.star_outline,
                    color:Colors.black45
                ),
              ),

            ],
          ),
          FutureBuilder(
            future: httpService.getCurrency(selectedFromCurrency, selectedToCurrency),
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
            child:ListView(
              children: <Widget>[

                Card(
                    child:ListTile(
                      title:Row(
                        children: [
                          const Text("1 EUR"),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          FutureBuilder(
                            future: httpService.getCurrency("EUR", "HUF"),
                            builder: (BuildContext context,value) {
                              if (value.hasData) {
                                String currency = value.data.toString();
                                return

                                  Text(currency,style: TextStyle(fontWeight: FontWeight.bold));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),

                          const Text(" HUF"),

                          const Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey,),
                            ),
                          ),
                        ],
                      ),
                    )
                ),

                Card(
                    child:ListTile(
                      title:Row(
                        children: [
                          const Text("1 EUR"),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          FutureBuilder(
                            future: httpService.getCurrency("EUR", "HUF"),
                            builder: (BuildContext context,value) {
                              if (value.hasData) {
                                String currency = value.data.toString();
                                return

                                  Text(currency,style: TextStyle(fontWeight: FontWeight.bold));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),

                          const Text(" HUF"),

                          const Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey,),
                            ),
                          ),
                        ],
                      ),
                    )
                ),


              ],
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