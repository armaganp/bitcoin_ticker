import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart' as coin_data;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'card.dart';

const apiKey = '5C930EC0-DD33-41A5-88F7-1EBF04E4FFE3'; // api-key

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = 'AUD';
  dynamic rate;
  dynamic vUpdateRate = 0;

  Future<dynamic> fHttpTest(String currency) async {
    var url =
        'http://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$apiKey';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jsonResponse = convert.jsonDecode(response.body);
      rate = jsonResponse['rate'];
      return rate;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fUpdate('AUD');
  }

  Wcard card1;
  Wcard card2;
  Wcard card3;
  void fUpdate(String val) async {
    rate = await fHttpTest(val);
    card1 =
        Wcard(baseValue: 'BTC', dropdownValue: dropdownValue, updateRate: rate);
    card2 =
        Wcard(baseValue: 'ONE', dropdownValue: dropdownValue, updateRate: rate);
    card3 =
        Wcard(baseValue: 'BUE', dropdownValue: dropdownValue, updateRate: rate);
    setState(() {
      dropdownValue = val;
      vUpdateRate = rate;
    });
  }

  DropdownButton fDropdownButton() {
    List<DropdownMenuItem<String>> vItems = [];
    for (String currency in coin_data.currenciesList) {
      vItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return (DropdownButton<String>(
      value: dropdownValue,
      items: vItems,
      onChanged: (val) {
        fUpdate(val);
      },
    ));
  }

  CupertinoPicker fCupertinoPicker() {
    List<Text> vItems = [];
    for (String currency in coin_data.currenciesList) {
      vItems.add(Text(currency));
    }
    return (CupertinoPicker(
      squeeze: 1.3,
      diameterRatio: 16.0,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(vItems[selectedIndex]);
      },
      children: vItems,
      looping: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                card1.getCard(),
                card2.getCard(),
                card3.getCard(),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 8.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? fCupertinoPicker() : fDropdownButton(),
          ),
        ],
      ),
    );
  }
}
