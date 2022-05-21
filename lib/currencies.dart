import 'package:flutter/material.dart';
import 'http_service.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);
  @override
  _CurrencyPage createState() => _CurrencyPage();
}

class _CurrencyPage extends State<CurrencyPage> {
  final HttpService httpService = HttpService();
  final items = ['EUR','USD','HUF','BTC','GBP','PLN','CZK','SEK','NOK','DKK','CHF','ZAR','AUD','JPY','NZD','TRY','BRL','CAD','CNY','HKD','INR','ILS','MYR','MXN','SGD','RON','IDR','PHP','ARS','THB','NGN','PKR','AED','UAH','BGN','HRK','RSD','LTC','ETH','BCH','XRP','CLP','XNO','TRX','DAI','DOGE','USDT','BTCV','KRW','EGP','SAR','QAR','ADA','BUSD'];
  String selectedFromCurrency = 'EUR';
  String selectedToCurrency = 'HUF';
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
              DropdownButton(
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
                  });
                },
              ),
              const Icon(
                Icons.arrow_right_alt,
                color: Colors.black,
                size: 30.0,
              ),

              DropdownButton(
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
                  });
                },
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
        ])
      ),
    );
  }
}