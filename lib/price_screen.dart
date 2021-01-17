import 'package:flutter/material.dart';
import 'coin_data.dart' as coin_data;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = 'AUD';
  // var mItems = <DropdownMenuItem<String>>[]; // equal to below statement
  List<DropdownMenuItem<String>> mItems = []; //from udemy
  @override
  void initState() {
    super.initState();
    addItems();
  }

  // from udemy
  List<DropdownMenuItem<String>> dropdownMenuItems() {
    for (int i = 0; i < coin_data.currenciesList.length; i++) {
      String currency = coin_data.currenciesList[i];
      var mItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      mItems.add(mItem);
    }
    return mItems;
  }

  // this is my solving
  void addItems() {
    for (var currency in coin_data.currenciesList) {
      mItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      ); //for loop
    }
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 8.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: dropdownValue,
              items: mItems,
              // items: dropdownMenuItems(),
              onChanged: (val) {
                setState(() {
                  dropdownValue = val;
                  print(val);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
