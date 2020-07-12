import 'package:coins/services/coin_data.dart';
import 'package:coins/services/price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedItem = currenciesList[0] ?? 'USD';
  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<DropdownMenuItem<String>> dp = [];
    for (String currency in currenciesList) {
      dp.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return dp;
  }

  List<Text> _getDropdownItemsIOS() {
    List<Text> dp = [];
    for (String currency in currenciesList) {
      dp.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }
    return dp;
  }

  String _priceBTCUSD = '';
  @override
  void initState() {
    super.initState();
    //get the bitcoin data
  }

  void _getPricingData(String cryptoCurrencyName) async {
    PriceModel priceModel = PriceModel();
    var data = await priceModel.getPrice(cryptoCurrencyName); //priceModel.getBTCUSD();
    setState(() {
      if (data != null) {
        print('DATA Success 200');
        _priceBTCUSD = data['last'].toString();
      } else {
        print('DATA FAIL 404');
        _priceBTCUSD = '?';
      }
    });
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
        children: [
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
                  '1 BTC = $_priceBTCUSD USD',
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
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: Theme.of(context).platform == TargetPlatform.android
                ? DropdownButton<String>(
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                    value: _selectedItem,
                    items: _getDropdownItems(),
                  )
                : CupertinoPicker(
                    children: _getDropdownItemsIOS(),
                    backgroundColor: Colors.black,
                    itemExtent: 32.0,
                    diameterRatio: 0.75,
                    onSelectedItemChanged: (selectedIndex) {
                      //print(selectedIndex);
                      _getPricingData(currenciesList[selectedIndex]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
