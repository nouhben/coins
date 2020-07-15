import 'dart:convert';

import 'package:coins/services/price.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  //https://apiv2.bitcoinaverage.com/indices/{symbol_set}/ticker/{symbol
  final String url;
  NetworkHelper({this.url});
  Future getData() async {
    http.Response response = await http.get(
      url,
      headers: {'x-ba-key': apiKey},
    );
    if (response.statusCode == 200) {
      print('Response success: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('ERROR: CAN\'T connect to API ==> ${response.statusCode}');
      return null;
    }
  }
}
