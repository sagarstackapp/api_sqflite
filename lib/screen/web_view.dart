import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDemo extends StatefulWidget {
  @override
  WebViewDemoState createState() => WebViewDemoState();
}

class WebViewDemoState extends State<WebViewDemo> {
  @override
  Widget build(BuildContext context) {
    print('CurrentPage --> $runtimeType');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: WebView(
          initialUrl:
              'https://salesapp-auth.nexware.app/connect/authorize?response_type=token&client_id=salesapp.portal&redirect_uri=https://salesapp-auth.nexware.app/silentRenew&scope=gateway.salesapp.portal',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
