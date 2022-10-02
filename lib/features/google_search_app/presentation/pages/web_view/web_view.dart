import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String link;
  const WebViewPage({Key? key,required this.link}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState(){
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: WebView(
      initialUrl: widget.link,
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
