import 'dart:ui';

import 'package:exchange_rate/http_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Favorite.dart';

class CurrancyCard extends StatefulWidget {
  final String fromCurrancy;
  final String toCurrancy;
  CurrancyCard({required this.fromCurrancy, required this.toCurrancy});
  @override
  _CurrancyCard createState() => _CurrancyCard();
}

class _CurrancyCard extends State<CurrancyCard> {

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Card(
        child:ListTile(
          title:Row(
            children: [
              Text("1 ${widget.fromCurrancy} "),
              const Icon(
                Icons.arrow_right_alt,
                color: Colors.black,
                size: 30.0,
              ),
              FutureBuilder(
                future: httpService.getCurrency(widget.fromCurrancy, widget.toCurrancy),
                builder: (BuildContext context,value) {
                  if (value.hasData) {
                    String currency = value.data.toString();
                    return

                      Text(currency,style: const TextStyle(fontWeight: FontWeight.bold));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                },
              ),

              Text(" ${widget.toCurrancy}"),

              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey,),
                ),
              ),
            ],
          ),
        )
    );
  }
}