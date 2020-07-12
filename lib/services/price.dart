import 'package:coins/services/networking.dart';

const String apiURL = 'https://apiv2.bitcoinaverage.com/indices';
const String apiKey = 'NmVkMjA5MWE3YWVjNDMyOWIxMzBiMWM5ZmQyZTMyMWY';

class PriceModel {
  Future<dynamic> getBTCUSD() async {
    String _url = '$apiURL/global/ticker/BTCUSD';
    var priceData = await NetworkHelper(url: _url).getData();
    return priceData;
  }

  Future<dynamic> getPrice(String currencies) async {
    String _url = '$apiURL/global/ticker/BTC${currencies.toUpperCase()}';
    var priceData = await NetworkHelper(url: _url).getData();
    return priceData;
  }
}
