//2. Import the required packages.
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '5C930EC0-DD33-41A5-88F7-1EBF04E4FFE3';

class CoinData {
  //3. Create the Asynchronous method getCoinData() that returns a Future (the price data).
  static Future<List<double>> getCoinData(String selectedCurrency) async {
    String requestURL;
    List<double> rateList = [];
    for (String s in cryptoList) {
      requestURL = '$coinAPIURL/$s/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        rateList.add(decodedData['rate']);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return rateList;
  }
}
