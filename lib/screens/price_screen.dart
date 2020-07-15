import 'package:coins/services/coin_data.dart';
import 'package:coins/services/price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = currenciesList[0] ?? 'USD';
  String _btcPrice = '';
  String _ethPrice = '';
  String _ltcPrice = '';
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
      dp.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return dp;
  }

  Widget _getDropdown() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return DropdownButton<String>(
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedCurrency = value;
          });
        },
        value: _selectedCurrency,
        items: _getDropdownItems(),
      );
    }
    return CupertinoPicker(
      children: _getDropdownItemsIOS(),
      backgroundColor: Colors.black,
      itemExtent: 32.0,
      diameterRatio: 0.75,
      onSelectedItemChanged: (selectedIndex) {
        //print(selectedIndex);
        _getPricingData(currenciesList[selectedIndex]);
      },
    );
  }

  //String _cryptoName = cryptoList[0];
  @override
  void initState() {
    super.initState();
    //get the bitcoin data
    _getPricingData(_selectedCurrency);
  }

  void _getPricingData(String currency) async {
    String btcData = await _getPriceCryptoCurrency('BTC$currency');
    setState(() {
      _btcPrice = btcData;
    });
    String ltcData = await _getPriceCryptoCurrency('LTC$currency');
    setState(() {
      _ltcPrice = ltcData;
    });
    String ethData = await _getPriceCryptoCurrency('ETH$currency');
    setState(() {
      _ethPrice = ethData;
    });
  }

  Future<String> _getPriceCryptoCurrency(String cryptoCurr) async {
    var data = await PriceModel().getPrice(cryptoCurr);
    if (data != null) {
      return data['last'].toString();
    }
    return '?';
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
          Column(
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
                      '1 BTC = $_btcPrice $_selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                      '1 ${cryptoList[1]} = $_ethPrice $_selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                      '1 ${cryptoList[2]} = $_ltcPrice $_selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: _getDropdown(),
          ),
        ],
      ),
    );
  }
}
