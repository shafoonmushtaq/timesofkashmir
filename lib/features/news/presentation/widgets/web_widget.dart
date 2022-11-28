import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  final String url;
  const WebPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}
