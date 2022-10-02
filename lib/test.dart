/*import 'dart:convert';
import 'dart:developer';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
*/

  // var priceUrl = Uri.parse('https://coinmarketcap.com/currencies/bitcoin/');
  // var response = await http.get(priceUrl);
  // var document = parser.parse(response.body);
  // var btcClass = document.getElementsByClassName("priceValue ");
  // log(btcClass[0].text);
//_________________________________________________
/*

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CryptoHomePage extends StatelessWidget {
  const CryptoHomePage({Key? key}) : super(key: key);

  Future img() async{

    var priceUrl = Uri.https( 'candlestick-chart.p.rapidapi.com','/binance',{'symbol': 'BTCUSDT', 'interval': '4h', 'limit': '300',});
    var response = await http.get(priceUrl,headers:{
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': 'a621e91a4fmshfa5384707e3db8ap134b55jsn38c6f8611a98',
      'X-RapidAPI-Host': 'candlestick-chart.p.rapidapi.com'
    });

    var tojson = json.decode(response.body);
    String img = tojson['chartImage'];
    Uint8List unit8 = base64.decode(img);
    return unit8;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: img(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.data!=null)
            return Image(image: MemoryImage(snapshot.data),);
          else
            return SizedBox.shrink();
        },
      ),
    );
  }
}
*/
