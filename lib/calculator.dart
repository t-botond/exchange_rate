import 'dart:core';
import 'dart:ui';

import 'package:exchange_rate/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorPage extends StatefulWidget {
  final String fromCurrancy;
  final String toCurrancy;
  const CalculatorPage({Key? key, required this.fromCurrancy, required this.toCurrancy}) : super(key: key);
  @override
  _CalculatorPage createState() => _CalculatorPage();
}


class _CalculatorPage extends State<CalculatorPage> {
  double initialFromValue = 1.0;
  double initialToValue = 1.0;
  double rate=1.0;
  final HttpService httpService = HttpService();

  TextEditingController _fromController =  TextEditingController();
  TextEditingController _toController =  TextEditingController();
  @override
  void initState() {
    super.initState();
    loadCurrancy();
    _toController.text = "";
    _fromController.text = initialFromValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('${widget.fromCurrancy} to ${widget.toCurrancy} calculator'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Calculator', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  labelText: widget.fromCurrancy,
                ),
                controller: _fromController ,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))],
                onChanged: (value) {
                  double val=value.isEmpty?0.0:double.parse(value);
                  double res= val*rate;
                  setState(() {
                    _toController.text=res.toString();
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_upward),
                  Icon(Icons.arrow_downward),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: widget.toCurrancy,
                ),
                controller:_toController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))],
                onChanged: (value) {
                  double val=value.isEmpty?0.0:double.parse(value);
                  double res= val*(1.0/rate);
                  setState(() {
                    _fromController.text=res.toString();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadCurrancy() async{
    String loadedRate=await httpService.getCurrency(widget.fromCurrancy, widget.toCurrancy);

    initialToValue= double.parse(loadedRate.toString());
    rate=initialToValue;
    _toController.text = initialToValue.toString();
  }

}